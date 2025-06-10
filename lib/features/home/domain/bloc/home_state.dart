import 'package:bloc_management/core/base/base_state.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends BaseState<dynamic> with EquatableMixin {
  final int selectedTab;
  const HomeState({this.selectedTab = 0, super.data, super.error, super.isLoading = false});

  @override
  List<Object?> get props => [selectedTab, data, error, isLoading];
}

class HomeInitial extends HomeState {
  const HomeInitial({int selectedTab = 0}) : super(selectedTab: selectedTab);
}

class HomeLoading extends HomeState {
  const HomeLoading({int selectedTab = 0}) : super(isLoading: true, selectedTab: selectedTab);
}

class HomeLoaded extends HomeState {
  const HomeLoaded({int selectedTab = 0}) : super(selectedTab: selectedTab);
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message, {int selectedTab = 0}) : super(error: message, selectedTab: selectedTab);

  @override
  List<Object?> get props => [message, selectedTab];
}
