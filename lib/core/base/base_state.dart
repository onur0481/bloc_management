import 'package:equatable/equatable.dart';

abstract class BaseState<T> extends Equatable {
  final T? data;
  final String? error;
  final bool isLoading;

  const BaseState({
    this.data,
    this.error,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [data, error, isLoading];
}
