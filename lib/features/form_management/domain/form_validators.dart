import 'package:formz/formz.dart';

class NameInput extends FormzInput<String, String> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return 'İsim alanı boş bırakılamaz';
    }
    if (value.length < 2) {
      return 'İsim en az 2 karakter olmalıdır';
    }
    return null;
  }
}

class EmailInput extends FormzInput<String, String> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([super.value = '']) : super.dirty();

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );

  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return 'E-posta alanı boş bırakılamaz';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Geçerli bir e-posta adresi giriniz';
    }
    return null;
  }
}

class PhoneInput extends FormzInput<String, String> {
  const PhoneInput.pure() : super.pure('');
  const PhoneInput.dirty([super.value = '']) : super.dirty();

  static final _phoneRegex = RegExp(
    r'^[0-9]{10}$',
  );

  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return 'Telefon alanı boş bırakılamaz';
    }
    if (!_phoneRegex.hasMatch(value)) {
      return 'Geçerli bir telefon numarası giriniz (10 haneli)';
    }
    return null;
  }
}
