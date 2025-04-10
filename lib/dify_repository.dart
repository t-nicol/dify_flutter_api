import 'package:dify_api/entities/chat_message_request.dart';
import 'package:dify_api/entities/chat_message_response.dart';
import 'package:dify_api/entities/conversation.dart';
import 'package:dify_api/entities/file_upload_response.dart';
import 'package:dify_api/entities/feedback_request.dart';
import 'package:dify_api/entities/message.dart';
import 'package:dify_api/entities/conversation_rename_request.dart';
import 'package:dify_api/entities/paginated_response.dart';
import 'package:dify_api/entities/success_response.dart';
import 'package:dio/dio.dart';

abstract class DifyRepository {
  Future<ChatMessageResponse> sendChatMessage(ChatMessageRequest request);

  Future<FileUploadResponse> uploadFile(String filePath, String userId);

  Future<SuccessResponse> stopGeneration(String messageId, String userId);

  Future<SuccessResponse> submitMessageFeedback(
      String messageId, FeedbackRequest feedback);

  Future<List<String>> getSuggestedQuestions(String messageId, String userId);

  Future<PaginatedResponse<Message>> listMessages({
    required String conversationId,
    required String userId,
    int limit = 20,
    String? lastId,
  });

  Future<PaginatedResponse<Conversation>> listConversations({
    required String userId,
    String? lastId,
    int limit = 20,
    String sortBy = '-updated_at',
  });

  Future<SuccessResponse> deleteConversation(
      String conversationId, String userId);

  Future<Conversation> renameConversation(
      String conversationId, ConversationRenameRequest request);

  Future<Map<String, String>> audioToText(String filePath, String userId);

  Future<List<int>> textToAudio(String text, String userId,
      {String? messageId});

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
  Future<FileUploadResponse> uploadFile(String filePath, String userId) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'user': userId,
    });
    final response = await _dio.post('/files/upload', data: formData);
    return FileUploadResponse.fromJson(response.data);
  }

  @override
  Future<SuccessResponse> stopGeneration(
      String messageId, String userId) async {
    final response = await _dio
        .post('/chat-messages/$messageId/stop', data: {'user': userId});
    return SuccessResponse.fromJson(response.data);
  }

  @override
  Future<SuccessResponse> submitMessageFeedback(
      String messageId, FeedbackRequest feedback) async {
    final response = await _dio.post('/chat-messages/$messageId/feedbacks',
        data: feedback.toJson());
    return SuccessResponse.fromJson(response.data);
  }

  @override
  Future<List<String>> getSuggestedQuestions(
      String messageId, String userId) async {
    final response = await _dio.get('/messages/$messageId/suggested-questions',
        queryParameters: {'user': userId});
    return List<String>.from(response.data['questions']);
  }

  @override
  Future<PaginatedResponse<Message>> listMessages({
    required String conversationId,
    required String userId,
    int limit = 20,
    String? lastId,
  }) async {
    final queryParams = {
      'conversation_id': conversationId,
      'user': userId,
      'limit': limit,
      if (lastId != null) 'last_id': lastId,
    };

    final response = await _dio.get('/messages', queryParameters: queryParams);

    return PaginatedResponse<Message>.fromJson(
      response.data,
      (json) => Message.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<Conversation>> listConversations({
    required String userId,
    String? lastId,
    int limit = 20,
    String sortBy = '-updated_at',
  }) async {
    final queryParams = {
      'user': userId,
      'limit': limit,
      'sort_by': sortBy,
      if (lastId != null) 'last_id': lastId,
    };

    final response =
        await _dio.get('/conversations', queryParameters: queryParams);

    return PaginatedResponse<Conversation>.fromJson(
      response.data,
      (json) => Conversation.fromJson(json),
    );
  }

  @override
  Future<SuccessResponse> deleteConversation(
      String conversationId, String userId) async {
    final response = await _dio
        .delete('/conversations/$conversationId', data: {'user': userId});
    return SuccessResponse.fromJson(response.data);
  }

  @override
  Future<Conversation> renameConversation(
      String conversationId, ConversationRenameRequest request) async {
    final response = await _dio.post('/conversations/$conversationId/name',
        data: request.toJson());
    return Conversation.fromJson(response.data);
  }

  @override
  Future<Map<String, String>> audioToText(
      String filePath, String userId) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'user': userId,
    });
    final response = await _dio.post('/audio-to-text', data: formData);
    return {'text': response.data['text']};
  }

  @override
  Future<List<int>> textToAudio(String text, String userId,
      {String? messageId}) async {
    final data = {
      'text': text,
      'user': userId,
      if (messageId != null) 'message_id': messageId,
    };

    final response = await _dio.post(
      '/text-to-audio',
      data: data,
      options: Options(responseType: ResponseType.bytes),
    );

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getMeta() async {
    final response = await _dio.get('/meta');
    return response.data;
  }
}
