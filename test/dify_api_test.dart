import 'package:flutter_test/flutter_test.dart';
import 'package:dify_api/dify_repository.dart';
import 'package:dify_api/entities/chat_message_request.dart';
import 'package:dify_api/entities/chat_message_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '/Users/tungpt/Development/thanhtunguet/dify_api/.env');

  final apiKey = dotenv.env['API_KEY']!;
  final baseUrl = dotenv.env['BASE_URL']!;
  final testConversationId = dotenv.env['TEST_CONVERSATION_ID']!;
  final testMessageId = dotenv.env['TEST_MESSAGE_ID']!;
  final dio = Dio();
  final repository =
      DifyRepositoryImpl(dio: dio, baseUrl: baseUrl, apiKey: apiKey);

  group('DifyRepository Tests', () {
    test('sendChatMessage', () async {
      final request = ChatMessageRequest(
        conversationId: testConversationId,
        query: '',
        user: '',
      );
      final response = await repository.sendChatMessage(request);
      expect(response, isA<ChatMessageResponse>());
    });

    test('uploadFile', () async {
      final filePath = 'test_resources/sample.txt';
      final userId = 'test_user';
      final fileId = await repository.uploadFile(filePath, userId);
      expect(fileId, isNotEmpty);
    });

    test('stopGeneration', () async {
      final taskId = 'test_task_id';
      await repository.stopGeneration(taskId);
      // No exception means success
    });

    test('submitMessageFeedback', () async {
      final feedback = {'rating': 5, 'comment': 'Great response!'};
      await repository.submitMessageFeedback(testMessageId, feedback);
      // No exception means success
    });

    test('getSuggestedReplies', () async {
      final replies = await repository.getSuggestedReplies(testMessageId);
      expect(replies, isA<List<String>>());
    });

    test('listMessages', () async {
      final messages = await repository.listMessages();
      expect(messages, isA<List<dynamic>>());
    });

    test('listConversations', () async {
      final conversations = await repository.listConversations();
      expect(conversations, isA<List<dynamic>>());
    });

    test('deleteConversation', () async {
      await repository.deleteConversation(testConversationId);
      // No exception means success
    });

    test('renameConversation', () async {
      await repository.renameConversation(testConversationId,
          autoGenerate: false);
      // No exception means success
    });

    test('audioToText', () async {
      final filePath = 'test_resources/sample_audio.mp3';
      final text = await repository.audioToText(filePath);
      expect(text, isNotEmpty);
    });

    test('textToAudio', () async {
      final text = 'Hello, this is a test.';
      final audioUrl = await repository.textToAudio(text);
      expect(audioUrl, isNotEmpty);
    });

    test('getInfo', () async {
      final info = await repository.getInfo();
      expect(info, isA<Map<String, dynamic>>());
    });

    test('getParameters', () async {
      final parameters = await repository.getParameters();
      expect(parameters, isA<Map<String, dynamic>>());
    });

    test('getMeta', () async {
      final meta = await repository.getMeta();
      expect(meta, isA<Map<String, dynamic>>());
    });
  });
}
