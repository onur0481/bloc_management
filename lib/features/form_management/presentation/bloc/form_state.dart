import 'package:bloc_management/core/base/base_state.dart';
import '../../domain/form_validators.dart';
import '../../domain/form_status.dart';

class FormState extends BaseState<Map<String, dynamic>> {
  final NameInput name;
  final EmailInput email;
  final PhoneInput phone;
  final FormStatus status;
  final bool isValid;
  final Map<String, dynamic> _data;
  final bool _isLoading;

  FormState({
    this.name = const NameInput.pure(),
    this.email = const EmailInput.pure(),
    this.phone = const PhoneInput.pure(),
    this.status = FormStatus.pure,
    this.isValid = false,
  })  : _data = {
          'name': name.value,
          'email': email.value,
          'phone': phone.value,
        },
        _isLoading = status == FormStatus.submissionInProgress;

  @override
  Map<String, dynamic> get data => _data;

  @override
  bool get isLoading => _isLoading;

  @override
  String? get message => null;

  FormState copyWith({
    NameInput? name,
    EmailInput? email,
    PhoneInput? phone,
    FormStatus? status,
    bool? isValid,
  }) {
    return FormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [name, email, phone, status, isValid];
}
