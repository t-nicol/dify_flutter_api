class ConversationRenameRequest {
  final String? name;
  final bool autoGenerate;
  final String user;

  ConversationRenameRequest({
    this.name,
    this.autoGenerate = false,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      'auto_generate': autoGenerate,
      'user': user,
    };
  }
}
