import 'package:bloc_management/core/base/base_state.dart';
import 'package:bloc_management/core/models/api_response.dart';

mixin HandleApiCallMixin {
  /// Veri döndüren işlemler için
  Future<void> handleApiCall<T>({
    required Future<ApiResponse<T>> Function() apiCall,
    required void Function(BaseState<T>) emitState,
    void Function(T data)? onSuccess,
    void Function(String? message)? onError,
    void Function()? onNoContent,
  }) async {
    emitState(LoadingState<T>());

    final response = await apiCall();
    response.when(
      success: (data) {
        emitState(LoadedState<T>(data));
        onSuccess?.call(data);
      },
      error: (message, type) {
        emitState(ErrorState<T>(message));
        onError?.call(message);
      },
      noContent: () {
        emitState(NoContentState<T>());
        onNoContent?.call();
      },
    );
  }

  /// Yan etki (void) işlemler için
  Future<void> handleVoidApiCall({
    required Future<ApiResponse<void>> Function() apiCall,
    void Function(BaseState<void>)? emitState,
    required void Function() onSuccess,
    void Function(String? message)? onError,
    void Function()? onNoContent,
  }) async {
    emitState?.call(LoadingState<void>());
    final response = await apiCall();
    response.when(
      success: (_) => onSuccess(),
      error: (message, type) {
        emitState?.call(ErrorState<void>(message));
        onError?.call(message);
      },
      noContent: () => onNoContent?.call(),
    );
  }
}
