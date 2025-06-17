import 'package:bloc_management/core/base/base_state.dart';
import 'package:bloc_management/core/models/api_response.dart';

mixin HandleApiCallMixin {
  Future<void> handleApiCall<T>({
    required Future<ApiResponse<T>> Function() apiCall,
    required void Function(BaseState<T>) emitState,
  }) async {
    emitState(const LoadingState());

    final response = await apiCall();
    response.when(
      success: (data) => emitState(LoadedState(data)),
      error: (message, type) => emitState(ErrorState(message)),
      noContent: () => emitState(LoadedState(null as T)),
    );
  }
}
