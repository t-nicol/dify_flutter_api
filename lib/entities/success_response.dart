class SuccessResponse {
  final String result;

  SuccessResponse({
    required this.result,
  });

  factory SuccessResponse.fromJson(Map<String, dynamic> json) {
    return SuccessResponse(
      result: json['result'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
    };
  }
}
