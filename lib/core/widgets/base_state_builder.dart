import 'package:flutter/material.dart';
import 'package:bloc_management/core/base/base_state.dart';

class BaseStateBuilder<T> extends StatelessWidget {
  final BaseState state;
  final Widget Function(T data) onLoaded;
  final Widget Function(String? message)? onError;
  final Widget? onLoading;
  final Widget? onNoContent;

  const BaseStateBuilder({
    super.key,
    required this.state,
    required this.onLoaded,
    this.onError,
    this.onLoading,
    this.onNoContent,
  });

  @override
  Widget build(BuildContext context) {
    if (state is LoadingState) {
      return onLoading ?? const Center(child: CircularProgressIndicator());
    }

    if (state is LoadedState<T>) {
      return onLoaded((state as LoadedState<T>).data!);
    }

    if (state is ErrorState) {
      if (onError != null) {
        return onError!((state as ErrorState).message);
      }
      return Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Hata'),
                content: Text((state as ErrorState).message ?? ''),
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

    if (state is NoContentState) {
      return onNoContent ?? const Center(child: Text('İçerik bulunamadı'));
    }

    return const SizedBox.shrink();
  }
}
