class PaginatedResponse<T> {
  final List<T> data;
  final int limit;
  final bool hasMore;

  PaginatedResponse({
    required this.data,
    required this.limit,
    required this.hasMore,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    final List<dynamic> itemsJson = json['data'] as List<dynamic>;
    return PaginatedResponse<T>(
      data: itemsJson.map((itemJson) => fromJsonT(itemJson)).toList(),
      limit: json['limit'] as int,
      hasMore: json['has_more'] as bool,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'data': data.map((item) => toJsonT(item)).toList(),
      'limit': limit,
      'has_more': hasMore,
    };
  }
}
