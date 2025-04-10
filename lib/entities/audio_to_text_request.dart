class AudioToTextRequest {
  final String file;
  final String user;

  AudioToTextRequest({
    required this.file,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'file': file,
      'user': user,
    };
  }
}
