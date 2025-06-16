import 'package:bloc_management/core/base/base_state.dart';

abstract class HomeState extends BaseState<dynamic> {
  final int selectedTab;
  final dynamic _data;
  final String? _message;
  final bool _isLoading;

  const HomeState({
    this.selectedTab = 0,
    dynamic data,
    String? message,
    bool isLoading = false,
  })  : _data = data,
        _message = message,
        _isLoading = isLoading;

  @override
  dynamic get data => _data;

  @override
  String? get message => _message;

  @override
  bool get isLoading => _isLoading;

  @override
  List<Object?> get props => [selectedTab, data, message, isLoading];
}

class HomeInitial extends HomeState {
  const HomeInitial({int selectedTab = 0}) : super(selectedTab: selectedTab);
}

class HomeLoading extends HomeState {
  const HomeLoading({int selectedTab = 0}) : super(isLoading: true, selectedTab: selectedTab);
}

class HomeLoaded extends HomeState {
  const HomeLoaded({int selectedTab = 0, dynamic data}) : super(selectedTab: selectedTab, data: data);
}

class HomeError extends HomeState {
  const HomeError(String message, {int selectedTab = 0}) : super(message: message, selectedTab: selectedTab);
}
