class FeedbackRequest {
  final String rating;
  final String user;
  final String? content;

  FeedbackRequest({
    required this.rating,
    required this.user,
    this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'user': user,
      if (content != null) 'content': content,
    };
  }
}
