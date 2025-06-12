class ApiResponse<T> {
  final T? data;
  final String? message;
  final String? type;

  ApiResponse({
    this.data,
    this.message,
    this.type,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse(
      data: data,
    );
  }

  factory ApiResponse.error(String message, {String type = 'toast'}) {
    return ApiResponse(
      message: message,
      type: type,
    );
  }
}
