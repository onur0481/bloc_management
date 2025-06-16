import 'package:equatable/equatable.dart';

abstract class BaseState<T> extends Equatable {
  final T? _data;
  final String? _message;
  final bool _isLoading;

  const BaseState({
    T? data,
    String? message,
    bool isLoading = false,
  })  : _data = data,
        _message = message,
        _isLoading = isLoading;

  T? get data => _data;
  String? get message => _message;
  bool get isLoading => _isLoading;

  @override
  List<Object?> get props => [data, message, isLoading];
}

class InitialState<T> extends BaseState<T> {
  const InitialState() : super();
}

class LoadingState<T> extends BaseState<T> {
  const LoadingState() : super(isLoading: true);
}

class LoadedState<T> extends BaseState<T> {
  const LoadedState(T data) : super(data: data);
}

class ErrorState<T> extends BaseState<T> {
  const ErrorState(String message) : super(message: message);
}

class NoContentState<T> extends BaseState<T> {
  const NoContentState() : super();
}
