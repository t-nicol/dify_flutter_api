import 'package:dify_api/entities/usage.dart';
import 'package:dify_api/entities/retriever_resource.dart';

class ChatMessageResponse {
  final String messageId;
  final String conversationId;
  final String answer;
  final Map<String, dynamic>? metadata;
  final Usage? usage;
  final List<RetrieverResource>? retrieverResources;

  ChatMessageResponse({
    required this.messageId,
    required this.conversationId,
    required this.answer,
    this.metadata,
    this.usage,
    this.retrieverResources,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessageResponse(
      messageId: json['message_id'],
      conversationId: json['conversation_id'],
      answer: json['answer'],
      metadata: json['metadata'],
      usage: json['metadata']?['usage'] != null
          ? Usage.fromJson(json['metadata']['usage'])
          : null,
      retrieverResources: json['metadata']?['retriever_resources'] != null
          ? (json['metadata']['retriever_resources'] as List)
              .map((r) => RetrieverResource.fromJson(r))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'conversation_id': conversationId,
      'answer': answer,
      if (metadata != null) 'metadata': metadata,
    };
  }
}
