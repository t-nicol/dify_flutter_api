class DifyFile {
  final String type;
  final String transferMethod;
  final String? url;
  final String? uploadFileId;

  DifyFile({
    required this.type,
    required this.transferMethod,
    this.url,
    this.uploadFileId,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
    'transfer_method': transferMethod,
    if (url != null) 'url': url,
    if (uploadFileId != null) 'upload_file_id': uploadFileId,
  };
}

class ChatMessageRequest {
  final String query;
  final Map<String, dynamic> inputs;
  final String responseMode;
  final String user;
  final String? conversationId;
  final List<DifyFile> files;
  final bool autoGenerateName;

  ChatMessageRequest({
    required this.query,
    this.inputs = const {},
    this.responseMode = 'blocking',
    required this.user,
    this.conversationId,
    this.files = const [],
    this.autoGenerateName = true,
  });

  Map<String, dynamic> toJson() => {
    'query': query,
    'inputs': inputs,
    'response_mode': responseMode,
    'user': user,
    if (conversationId != null) 'conversation_id': conversationId,
    if (files.isNotEmpty) 'files': files.map((f) => f.toJson()).toList(),
    'auto_generate_name': autoGenerateName,
  };
}