class FileInput {
  final String type;
  final String transferMethod;
  final String? url;
  final String? uploadFileId;

  FileInput({
    required this.type,
    required this.transferMethod,
    this.url,
    this.uploadFileId,
  });

  factory FileInput.fromJson(Map<String, dynamic> json) {
    return FileInput(
      type: json['type'],
      transferMethod: json['transfer_method'],
      url: json['url'],
      uploadFileId: json['upload_file_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'transfer_method': transferMethod,
      if (url != null) 'url': url,
      if (uploadFileId != null) 'upload_file_id': uploadFileId,
    };
  }
}
