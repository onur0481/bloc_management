import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/base/base_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<LoadHome>(_onLoadHome);
    on<TabChanged>(_onTabChanged);
  }

  void _onTabChanged(TabChanged event, Emitter<HomeState> emit) {
    print('Tab değişiyor: ${event.tabIndex}'); // Debug için
    if (state is HomeLoaded) {
      emit(HomeLoaded(selectedTab: event.tabIndex));
    } else {
      emit(HomeLoaded(selectedTab: event.tabIndex));
    }
  }

  Future<void> _onLoadHome(
    LoadHome event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading(selectedTab: state.selectedTab));
      await Future.delayed(const Duration(seconds: 1));
      emit(HomeLoaded(selectedTab: state.selectedTab));
    } catch (e) {
      emit(HomeError(e.toString(), selectedTab: state.selectedTab));
    }
  }
}
