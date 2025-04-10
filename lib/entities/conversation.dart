class Conversation {
  final String id;
  final String name;
  final Map<String, dynamic> inputs;
  final String status;
  final String introduction;
  final int createdAt;
  final int updatedAt;

  Conversation({
    required this.id,
    required this.name,
    required this.inputs,
    required this.status,
    required this.introduction,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      name: json['name'],
      inputs: json['inputs'],
      status: json['status'],
      introduction: json['introduction'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'inputs': inputs,
      'status': status,
      'introduction': introduction,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
