import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success(T data) = ApiResponseSuccess<T>;
  const factory ApiResponse.error(String message, {String? type}) = ApiResponseError<T>;
  const factory ApiResponse.noContent() = ApiResponseNoContent<T>;
}
