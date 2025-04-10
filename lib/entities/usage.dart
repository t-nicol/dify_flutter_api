class Usage {
  final int promptTokens;
  final String promptUnitPrice;
  final String promptPrice;
  final int completionTokens;
  final String completionUnitPrice;
  final String completionPrice;
  final int totalTokens;
  final String totalPrice;
  final String currency;
  final double latency;

  Usage({
    required this.promptTokens,
    required this.promptUnitPrice,
    required this.promptPrice,
    required this.completionTokens,
    required this.completionUnitPrice,
    required this.completionPrice,
    required this.totalTokens,
    required this.totalPrice,
    required this.currency,
    required this.latency,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      promptTokens: json['prompt_tokens'],
      promptUnitPrice: json['prompt_unit_price'],
      promptPrice: json['prompt_price'],
      completionTokens: json['completion_tokens'],
      completionUnitPrice: json['completion_unit_price'],
      completionPrice: json['completion_price'],
      totalTokens: json['total_tokens'],
      totalPrice: json['total_price'],
      currency: json['currency'],
      latency: json['latency'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prompt_tokens': promptTokens,
      'prompt_unit_price': promptUnitPrice,
      'prompt_price': promptPrice,
      'completion_tokens': completionTokens,
      'completion_unit_price': completionUnitPrice,
      'completion_price': completionPrice,
      'total_tokens': totalTokens,
      'total_price': totalPrice,
      'currency': currency,
      'latency': latency,
    };
  }
}
