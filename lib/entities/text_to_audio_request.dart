class TextToAudioRequest {
  final String? messageId;
  final String text;
  final String user;

  TextToAudioRequest({
    this.messageId,
    required this.text,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      if (messageId != null) 'message_id': messageId,
      'text': text,
      'user': user,
    };
  }
}
