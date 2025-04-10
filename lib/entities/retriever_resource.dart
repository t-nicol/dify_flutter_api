class RetrieverResource {
  final int position;
  final String datasetId;
  final String datasetName;
  final String documentId;
  final String documentName;

  RetrieverResource({
    required this.position,
    required this.datasetId,
    required this.datasetName,
    required this.documentId,
    required this.documentName,
  });

  factory RetrieverResource.fromJson(Map<String, dynamic> json) {
    return RetrieverResource(
      position: json['position'],
      datasetId: json['dataset_id'],
      datasetName: json['dataset_name'],
      documentId: json['document_id'],
      documentName: json['document_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'dataset_id': datasetId,
      'dataset_name': datasetName,
      'document_id': documentId,
      'document_name': documentName,
    };
  }
}
