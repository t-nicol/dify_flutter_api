# 📦 dify_api

A Dart client package for integrating with the Dify AI API. Supports chat messaging, file uploads, feedback, TTS/STT, and more.

---

## 🚀 Features
- Send chat messages (streaming/blocking)
- Upload files
- Stop message generation
- Submit feedback
- Get suggested replies
- Manage conversations
- Convert audio to text & text to audio
- Retrieve API info, parameters, and meta

---

## 🧱 Installation
Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  dify_api:
    git:
      url: https://github.com/thanhtunguet/dify_api.git
```

---

## ⚙️ Environment Setup

Create a `.env` file:

```dotenv
DIFY_API_KEY=your_api_key_here
```

Then load it at the app start:
```dart
import 'package:dotenv/dotenv.dart';

dotenv.load();
```

---

## 🛠 Usage

### Initialization
```dart
final repository = DifyRepositoryImpl(
  dio: Dio(),
  baseUrl: 'http://dify.supa.vn/v1',
  apiKey: dotenv.env['DIFY_API_KEY']!,
);
```

### Send Chat Message
```dart
final response = await repository.sendChatMessage(
  ChatMessageRequest(query: "Hello", user: "user-1")
);
print(response.answer);
```

### Upload File
```dart
final fileId = await repository.uploadFile('path/to/file.png', 'user-1');
```

### Get Info
```dart
final info = await repository.getInfo();
```

---

## 🧪 Run Tests
```bash
dart test
```

Uses:
- `http_mock_adapter` for mocking Dio
- `dotenv` for loading API keys

---

## 📄 License
[MIT](./LICENSE)

---

## 👨‍💻 Maintainer
Built with ❤️ by [thanhtunguet]. PRs welcome!
