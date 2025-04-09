import 'package:dify_api/entities/chat_message_request.dart';
import 'package:dify_api/entities/chat_message_response.dart';
import 'package:dio/dio.dart';

abstract class DifyRepository {
  Future<ChatMessageResponse> sendChatMessage(ChatMessageRequest request);

  Future<String> uploadFile(String filePath, String userId);

  Future<void> stopGeneration(String taskId);

  Future<void> submitMessageFeedback(
      String messageId, Map<String, dynamic> feedback);

  Future<List<String>> getSuggestedReplies(String messageId);

  Future<List<dynamic>> listMessages();

  Future<List<dynamic>> listConversations();

  Future<void> deleteConversation(String conversationId);

  Future<void> renameConversation(String conversationId,
      {bool autoGenerate = true});

  Future<String> audioToText(String filePath);

  Future<String> textToAudio(String text);

  Future<Map<String, dynamic>> getInfo();

  Future<Map<String, dynamic>> getParameters();

  Future<Map<String, dynamic>> getMeta();
}

class DifyRepositoryImpl implements DifyRepository {
  final Dio _dio;
  final String baseUrl;
  final String apiKey;

  DifyRepositoryImpl({
    required Dio dio,
    required this.baseUrl,
    required this.apiKey,
  }) : _dio = dio {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['Authorization'] = 'Bearer $apiKey';
  }

  @override
  Future<ChatMessageResponse> sendChatMessage(
      ChatMessageRequest request) async {
    final response = await _dio.post('/chat-messages', data: request.toJson());
    return ChatMessageResponse.fromJson(response.data);
  }

  @override
  Future<String> uploadFile(String filePath, String userId) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'user': userId,
    });
    final response = await _dio.post('/files/upload', data: formData);
    return response.data['id'];
  }

  @override
  Future<void> stopGeneration(String taskId) async {
    await _dio.post('/chat-messages/$taskId/stop');
  }

  @override
  Future<void> submitMessageFeedback(
      String messageId, Map<String, dynamic> feedback) async {
    await _dio.post('/messages/$messageId/feedbacks', data: feedback);
  }

  @override
  Future<List<String>> getSuggestedReplies(String messageId) async {
    final response = await _dio.get('/messages/$messageId/suggested');
    return List<String>.from(response.data);
  }

  @override
  Future<List<dynamic>> listMessages() async {
    final response = await _dio.get('/messages');
    return response.data;
  }

  @override
  Future<List<dynamic>> listConversations() async {
    final response = await _dio.get('/conversations');
    return response.data;
  }

  @override
  Future<void> deleteConversation(String conversationId) async {
    await _dio.delete('/conversations/$conversationId');
  }

  @override
  Future<void> renameConversation(String conversationId,
      {bool autoGenerate = true}) async {
    await _dio.post('/conversations/$conversationId/name', data: {
      'auto_generate': autoGenerate,
    });
  }

  @override
  Future<String> audioToText(String filePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });
    final response = await _dio.post('/audio-to-text', data: formData);
    return response.data['text'];
  }

  @override
  Future<String> textToAudio(String text) async {
    final response = await _dio.post('/text-to-audio', data: {'text': text});
    return response.data['audio_url'];
  }

  @override
  Future<Map<String, dynamic>> getInfo() async {
    final response = await _dio.get('/info');
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getParameters() async {
    final response = await _dio.get('/parameters');
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getMeta() async {
    final response = await _dio.get('/meta');
    return response.data;
  }
}
