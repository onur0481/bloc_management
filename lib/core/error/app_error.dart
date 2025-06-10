class AppError {
  final String message;
  final String? code;
  final dynamic originalError;

  AppError({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() {
    return 'AppError{message: $message, code: $code, originalError: $originalError}';
  }
}
