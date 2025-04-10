import 'package:dify_api/entities/message_file.dart';
import 'package:dify_api/entities/retriever_resource.dart';

class Message {
  final String id;
  final String conversationId;
  final Map<String, dynamic> inputs;
  final String query;
  final List<MessageFile> messageFiles;
  final String answer;
  final int createdAt;
  final Map<String, dynamic>? feedback;
  final List<RetrieverResource>? referenceResources;

  Message({
    required this.id,
    required this.conversationId,
    required this.inputs,
    required this.query,
    required this.messageFiles,
    required this.answer,
    required this.createdAt,
    this.feedback,
    this.referenceResources,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      conversationId: json['conversation_id'],
      inputs: json['inputs'],
      query: json['query'],
      messageFiles: (json['message_files'] as List?)
              ?.map((file) => MessageFile.fromJson(file))
              .toList() ??
          [],
      answer: json['answer'],
      createdAt: json['created_at'],
      feedback: json['feedback'],
      referenceResources: (json['reference_resources'] as List?)
          ?.map((resource) => RetrieverResource.fromJson(resource))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'inputs': inputs,
      'query': query,
      'message_files': messageFiles.map((file) => file.toJson()).toList(),
      'answer': answer,
      'created_at': createdAt,
      if (feedback != null) 'feedback': feedback,
      if (referenceResources != null)
        'reference_resources':
            referenceResources!.map((resource) => resource.toJson()).toList(),
    };
  }
}
