import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHome extends HomeEvent {
  const LoadHome();
}

class TabChanged extends HomeEvent {
  final int tabIndex;
  const TabChanged(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}
