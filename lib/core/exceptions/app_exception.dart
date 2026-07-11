class ApiException implements Exception {
  final int statusCode;
  final String message;
  final dynamic data;

  ApiException({required this.statusCode, required this.message, this.data});

  @override
  String toString() => message;

  bool get isNetworkError => statusCode == 0;

  bool get isTimeout => statusCode == 408;

  bool get isUnauthorized => statusCode == 401;

  bool get isServerError => statusCode >= 500;

  bool get isClientError => statusCode >= 400 && statusCode < 500;
}
