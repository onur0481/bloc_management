import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_state.dart';

abstract class BaseBloc<Event, State extends BaseState> extends Bloc<Event, State> {
  BaseBloc(State initialState) : super(initialState);

  Future<void> handleError(
    dynamic error,
    Emitter<State> emit,
    State Function(String error) errorState,
  ) async {
    emit(errorState(error.toString()));
  }

  Future<void> handleLoading(
    Emitter<State> emit,
    State Function(bool isLoading) loadingState,
  ) async {
    emit(loadingState(true));
  }

  Future<void> handleSuccess<T>(
    T data,
    Emitter<State> emit,
    State Function(T data) successState,
  ) async {
    emit(successState(data));
  }
}
