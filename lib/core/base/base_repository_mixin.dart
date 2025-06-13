import 'package:bloc_management/core/models/api_response.dart';

mixin BaseRepositoryMixin {
  /// API yanıtını güvenli bir şekilde parse eder
  T? parseResponse<T>(ApiResponse<T> response) {
    return response.maybeWhen(
      success: (data) => data,
      orElse: () => null,
    );
  }

  /// API yanıtını kontrol eder ve uygun şekilde işler
  ApiResponse<T> handleResponse<T>({
    required T? Function() parseData,
    String? errorMessage,
    String? errorType,
  }) {
    try {
      final data = parseData();
      if (data == null) {
        return const ApiResponse.noContent();
      }
      return ApiResponse.success(data);
    } catch (e) {
      return ApiResponse.error(errorMessage ?? 'Bir hata oluştu', type: errorType);
    }
  }

  /// API yanıtını kontrol eder ve liste dönüşü yapar
  ApiResponse<List<T>> handleListResponse<T>({
    required List<T>? Function() parseData,
    String? errorMessage,
    String? errorType,
  }) {
    try {
      final data = parseData();
      if (data == null || data.isEmpty) {
        return const ApiResponse.noContent();
      }
      return ApiResponse.success(data);
    } catch (e) {
      return ApiResponse.error(errorMessage ?? 'Bir hata oluştu', type: errorType);
    }
  }
}
