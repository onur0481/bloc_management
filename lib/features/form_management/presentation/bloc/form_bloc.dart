import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/base/base_bloc.dart';
import 'package:bloc_management/core/error/app_error.dart';
import 'package:formz/formz.dart';
import '../../domain/form_validators.dart';
import '../../domain/form_status.dart';
import 'form_event.dart';
import 'form_state.dart';

class FormBloc extends BaseBloc<FormEvent, FormState> {
  FormBloc() : super(FormState()) {
    on<FormNameChanged>(_onNameChanged);
    on<FormEmailChanged>(_onEmailChanged);
    on<FormPhoneChanged>(_onPhoneChanged);
    on<FormSubmitted>(_onSubmitted);
    on<FormReset>(_onReset);
  }

  void _onNameChanged(
    FormNameChanged event,
    Emitter<FormState> emit,
  ) {
    final name = NameInput.dirty(event.name);
    emit(state.copyWith(
      name: name,
      isValid: Formz.validate([name, state.email, state.phone]),
    ));
  }

  void _onEmailChanged(
    FormEmailChanged event,
    Emitter<FormState> emit,
  ) {
    final email = EmailInput.dirty(event.email);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([state.name, email, state.phone]),
    ));
  }

  void _onPhoneChanged(
    FormPhoneChanged event,
    Emitter<FormState> emit,
  ) {
    final phone = PhoneInput.dirty(event.phone);
    emit(state.copyWith(
      phone: phone,
      isValid: Formz.validate([state.name, state.email, phone]),
    ));
  }

  Future<void> _onSubmitted(
    FormSubmitted event,
    Emitter<FormState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FormStatus.submissionInProgress));

      if (state.isValid) {
        await Future.delayed(const Duration(seconds: 1));
        emit(state.copyWith(status: FormStatus.submissionSuccess));
      } else {
        await handleError(
          AppError(message: 'Form geçersiz'),
          emit,
          (error) => state.copyWith(status: FormStatus.submissionFailure),
        );
      }
    } catch (e) {
      await handleError(
        AppError(message: e.toString()),
        emit,
        (error) => state.copyWith(status: FormStatus.submissionFailure),
      );
    }
  }

  void _onReset(
    FormReset event,
    Emitter<FormState> emit,
  ) {
    emit(FormState());
  }
}
