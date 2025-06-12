class ApiResponse<T> {
  final T? data;
  final String? message;
  final String? type;
  final bool isSuccess;

  ApiResponse({
    this.data,
    this.message,
    this.type,
    required this.isSuccess,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse(
      data: data,
      isSuccess: true,
    );
  }

  factory ApiResponse.error(String message, {String type = 'toast'}) {
    return ApiResponse(
      message: message,
      type: type,
      isSuccess: false,
    );
  }
}
