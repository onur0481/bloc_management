import 'package:flutter/material.dart';
import 'package:bloc_management/core/base/base_state.dart';

class BaseLoadingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final BaseState state;
  final bool Function(BaseState state)? isDisabled;

  const BaseLoadingButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.state,
    this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = isDisabled?.call(state) ?? state is LoadingState;

    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      child: child,
    );
  }
}
