class MessageFile {
  final String id;
  final String type;
  final String url;
  final String belongsTo;

  MessageFile({
    required this.id,
    required this.type,
    required this.url,
    required this.belongsTo,
  });

  factory MessageFile.fromJson(Map<String, dynamic> json) {
    return MessageFile(
      id: json['id'],
      type: json['type'],
      url: json['url'],
      belongsTo: json['belongs_to'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'url': url,
      'belongs_to': belongsTo,
    };
  }
}
