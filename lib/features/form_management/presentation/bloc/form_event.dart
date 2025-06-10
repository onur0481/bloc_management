import 'package:equatable/equatable.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class FormNameChanged extends FormEvent {
  final String name;

  const FormNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class FormEmailChanged extends FormEvent {
  final String email;

  const FormEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class FormPhoneChanged extends FormEvent {
  final String phone;

  const FormPhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

class FormSubmitted extends FormEvent {
  const FormSubmitted();
}

class FormReset extends FormEvent {
  const FormReset();
}
