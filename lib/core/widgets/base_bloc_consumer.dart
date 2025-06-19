import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/base/base_state.dart';

class BaseBlocConsumer<B extends BlocBase<S>, S, T> extends StatelessWidget {
  final B bloc;
  final BaseState Function(S state) stateSelector;
  final Widget Function(T data) onLoaded;
  final void Function(BuildContext context, BaseState<T> state)? onStateChange;
  final Widget? onLoading;
  final Widget Function(String? message)? onError;
  final Widget? onNoContent;
  final bool Function(S previous, S current)? listenWhen;

  const BaseBlocConsumer({
    super.key,
    required this.bloc,
    required this.stateSelector,
    required this.onLoaded,
    this.onStateChange,
    this.onLoading,
    this.onError,
    this.onNoContent,
    this.listenWhen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      bloc: bloc,
      listenWhen: listenWhen,
      listener: (context, state) {
        final baseState = stateSelector(state);
        if (onStateChange != null) {
          onStateChange!(context, baseState as BaseState<T>);
        }
      },
      builder: (context, state) {
        final baseState = stateSelector(state);

        if (baseState is LoadingState) {
          return Scaffold(body: onLoading ?? const Center(child: CircularProgressIndicator()));
        }
        if (baseState is LoadedState<T>) {
          return onLoaded(baseState.data!);
        }
        if (baseState is ErrorState) {
          if (onError != null) return onError!(baseState.message);
          return Center(child: Text(baseState.message ?? 'Bir hata oluştu'));
        }
        if (baseState is NoContentState) {
          return onNoContent ?? const Center(child: Text('İçerik bulunamadı'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
