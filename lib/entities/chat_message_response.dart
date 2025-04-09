class RetrieverResource {
  final String datasetId;
  final String datasetName;
  final String documentId;
  final String documentName;
  final String segmentId;
  final double score;
  final String content;

  RetrieverResource({
    required this.datasetId,
    required this.datasetName,
    required this.documentId,
    required this.documentName,
    required this.segmentId,
    required this.score,
    required this.content,
  });

  factory RetrieverResource.fromJson(Map<String, dynamic> json) => RetrieverResource(
    datasetId: json['dataset_id'],
    datasetName: json['dataset_name'],
    documentId: json['document_id'],
    documentName: json['document_name'],
    segmentId: json['segment_id'],
    score: (json['score'] as num).toDouble(),
    content: json['content'],
  );
}

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;
  final String currency;
  final String totalPrice;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
    required this.currency,
    required this.totalPrice,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
    promptTokens: json['prompt_tokens'],
    completionTokens: json['completion_tokens'],
    totalTokens: json['total_tokens'],
    currency: json['currency'],
    totalPrice: json['total_price'],
  );
}

class Metadata {
  final Usage usage;
  final List<RetrieverResource> retrieverResources;

  Metadata({
    required this.usage,
    required this.retrieverResources,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    usage: Usage.fromJson(json['usage']),
    retrieverResources: (json['retriever_resources'] as List)
        .map((e) => RetrieverResource.fromJson(e))
        .toList(),
  );
}

class ChatMessageResponse {
  final String messageId;
  final String conversationId;
  final String mode;
  final String answer;
  final Metadata metadata;
  final int createdAt;

  ChatMessageResponse({
    required this.messageId,
    required this.conversationId,
    required this.mode,
    required this.answer,
    required this.metadata,
    required this.createdAt,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) => ChatMessageResponse(
    messageId: json['message_id'],
    conversationId: json['conversation_id'],
    mode: json['mode'],
    answer: json['answer'],
    metadata: Metadata.fromJson(json['metadata']),
    createdAt: json['created_at'],
  );
}