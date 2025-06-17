import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/base/base_state.dart';

class BaseBlocBuilder<B extends BlocBase<S>, S, T> extends StatelessWidget {
  final B bloc;
  final Widget Function(T data) onLoaded;
  final Widget Function(String? message)? onError;
  final Widget? onLoading;
  final Widget? onNoContent;
  final bool Function(S previous, S current)? buildWhen;
  final BaseState Function(S state) stateSelector;

  const BaseBlocBuilder({
    super.key,
    required this.bloc,
    required this.onLoaded,
    required this.stateSelector,
    this.onError,
    this.onLoading,
    this.onNoContent,
    this.buildWhen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      bloc: bloc,
      buildWhen: buildWhen,
      builder: (context, state) {
        final baseState = stateSelector(state);

        if (baseState is LoadingState) {
          return onLoading ?? const Center(child: CircularProgressIndicator());
        }

        if (baseState is LoadedState<T>) {
          return onLoaded(baseState.data!);
        }

        if (baseState is ErrorState) {
          if (onError != null) {
            return onError!(baseState.message);
          }
          return Builder(
            builder: (context) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Hata'),
                    content: Text(baseState.message ?? ''),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tamam'),
                      ),
                    ],
                  ),
                );
              });
              return const SizedBox.shrink();
            },
          );
        }

        if (baseState is NoContentState) {
          return onNoContent ?? const Center(child: Text('İçerik bulunamadı'));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
