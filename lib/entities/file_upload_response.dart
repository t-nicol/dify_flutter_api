class FileUploadResponse {
  final String id;
  final String name;
  final int size;
  final String extension;
  final String mimeType;
  final String createdBy;
  final int createdAt;

  FileUploadResponse({
    required this.id,
    required this.name,
    required this.size,
    required this.extension,
    required this.mimeType,
    required this.createdBy,
    required this.createdAt,
  });

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) {
    return FileUploadResponse(
      id: json['id'],
      name: json['name'],
      size: json['size'],
      extension: json['extension'],
      mimeType: json['mime_type'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'extension': extension,
      'mime_type': mimeType,
      'created_by': createdBy,
      'created_at': createdAt,
    };
  }
}
