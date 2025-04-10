# 🤖 Dify API - Flutter Client

A Flutter client package for seamlessly integrating with the Dify AI API platform. Provides a complete implementation for all Dify API endpoints, supporting chat messaging, file uploads, conversation management, audio transformations, and more.

## 📑 Table of Contents
- [Features](#-features)
- [Installation](#-installation)
- [Usage](#-usage)
  - [Setup](#setup)
  - [Chat Messages](#chat-messages)
  - [Files Management](#files-management)
  - [Conversations](#conversations)
  - [Audio Features](#audio-features)
  - [Feedback & Interactions](#feedback--interactions)
- [API Reference](#-api-reference)
- [Examples](#-examples)
- [License](#-license)

## 🚀 Features
- Send chat messages with streaming or blocking response modes
- Upload and manage files for multimodal interactions
- Control message generation (pause/stop)
- Submit and manage user feedback
- Get AI-suggested follow-up questions
- List, rename, and delete conversations
- Convert audio to text (speech recognition)
- Convert text to audio (text-to-speech)
- Retrieve application metadata and configuration

## 📦 Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  dify_api:
    git:
      url: https://github.com/thanhtunguet/dify_flutter_api.git
```

Then run:
```bash
flutter pub get
```

## 🔧 Usage

### Setup
Initialize the Dify repository with your API credentials:

```dart
import 'package:dify_api/dify_repository.dart';
import 'package:dio/dio.dart';

final difyRepository = DifyRepositoryImpl(
  dio: Dio(),
  baseUrl: 'https://dify.supa.vn/v1', // Your Dify API endpoint
  apiKey: 'your_api_key_here',
);
```

### Chat Messages
Send a chat message to the AI assistant:

```dart
import 'package:dify_api/entities/chat_message_request.dart';

final request = ChatMessageRequest(
  query: "How does photosynthesis work?",
  user: "user_123", // Unique user identifier
  responseMode: "streaming", // "streaming" or "blocking"
);

final response = await difyRepository.sendChatMessage(request);
print("Answer: ${response.answer}");
```

Stop an ongoing message generation:

```dart
await difyRepository.stopGeneration("message_id", "user_123");
```

### Files Management
Upload a file to use in conversations:

```dart
final uploadResponse = await difyRepository.uploadFile("/path/to/image.jpg", "user_123");
print("File ID: ${uploadResponse.id}");
```

### Conversations
List user conversations:

```dart
final conversations = await difyRepository.listConversations(userId: "user_123");
for (var conversation in conversations["data"]!) {
  print("Conversation: ${conversation.id} - ${conversation.name}");
}
```

Rename a conversation:

```dart
import 'package:dify_api/entities/conversation_rename_request.dart';

final request = ConversationRenameRequest(
  name: "New Conversation Name",
  user: "user_123",
);

final updatedConversation = await difyRepository.renameConversation("conversation_id", request);
```

Delete a conversation:

```dart
await difyRepository.deleteConversation("conversation_id", "user_123");
```

### Audio Features
Convert audio to text:

```dart
final textResult = await difyRepository.audioToText("/path/to/recording.mp3", "user_123");
print("Transcription: ${textResult['text']}");
```

Convert text to speech:

```dart
final audioBytes = await difyRepository.textToAudio("Hello, this is a test", "user_123");
// Save or play the audio bytes
```

### Feedback & Interactions
Submit feedback on a message:

```dart
import 'package:dify_api/entities/feedback_request.dart';

final feedback = FeedbackRequest(
  rating: "like", // "like" or "dislike"
  user: "user_123",
  content: "Very helpful explanation", // Optional comment
);

await difyRepository.submitMessageFeedback("message_id", feedback);
```

Get suggested follow-up questions:

```dart
final suggestions = await difyRepository.getSuggestedQuestions("message_id", "user_123");
for (var question in suggestions) {
  print("Suggested question: $question");
}
```

## 📚 API Reference

The package provides the following main methods:

- `sendChatMessage(ChatMessageRequest request)` - Send a chat message to the AI
- `uploadFile(String filePath, String userId)` - Upload a file for use in conversations
- `stopGeneration(String messageId, String userId)` - Stop an ongoing message generation
- `submitMessageFeedback(String messageId, FeedbackRequest feedback)` - Submit user feedback
- `getSuggestedQuestions(String messageId, String userId)` - Get suggested follow-up questions
- `listMessages({required String conversationId, required String userId, ...})` - List messages in a conversation
- `listConversations({required String userId, ...})` - List user conversations
- `deleteConversation(String conversationId, String userId)` - Delete a conversation
- `renameConversation(String conversationId, ConversationRenameRequest request)` - Rename a conversation
- `audioToText(String filePath, String userId)` - Convert audio to text
- `textToAudio(String text, String userId, {String? messageId})` - Convert text to audio
- `getMeta()` - Get application metadata

## 🧩 Examples

Check the `/example` directory for complete usage examples.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🔗 Links
- [Dify AI Official Website](https://dify.ai)
- [Dify API Documentation](https://docs.dify.ai/api-reference/introduction)

---

Built with ❤️ by [thanhtunguet](https://github.com/thanhtunguet)
