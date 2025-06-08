import 'package:dify_api/entities/file_input.dart';

class ChatMessageRequest {
  final Map<String, dynamic>? input;
  final String query;
  final String responseMode;
  final String user;
  final String? conversationId;
  final List<FileInput>? files;
  final bool autoGenerateName;

  ChatMessageRequest({
    this.input = const {},
    required this.query,
    this.responseMode = 'streaming',
    required this.user,
    this.conversationId,
    this.files,
    this.autoGenerateName = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'inputs': input, // changed from 'input' to 'inputs'
      'query': query,
      'response_mode': responseMode,
      'user': user,
      if (conversationId != null) 'conversation_id': conversationId,
      if (files != null && files!.isNotEmpty)
        'files': files!.map((file) => file.toJson()).toList(),
      'auto_generate_name': autoGenerateName,
    };
  }
}
