import 'package:barbearia/app/features/register_information/presenter/register_information_store.dart';
import 'package:barbearia/libraries/core/src/extension/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterInformationController extends Disposable {
  final RegisterInformationStore store;

  RegisterInformationController(this.store);

  ValueNotifier<String?> emailError = ValueNotifier(null);
  ValueNotifier<bool> emailValidation = ValueNotifier(false);
  ValueNotifier<String?> passwordError = ValueNotifier(null);
  ValueNotifier<bool> showPassword = ValueNotifier(false);
  ValueNotifier<String?> nameError = ValueNotifier(null);
  ValueNotifier<String?> phoneError = ValueNotifier(null);
  ValueNotifier<bool?> phoneNumber = ValueNotifier(false);

  Future<void> registerPersonal(
      String name, String email, String password, String phone) async {
    if (name.isEmpty) {
      nameError.value = 'nome não pode ser vazio';
    }
    if (email.isEmpty) {
      emailError.value = 'E-mail não pode ser vazio';
      return;
    }
    if (!email.isEmail) {
      emailError.value = 'Email não é valido.';
      return;
    }
    if (password.isEmpty) {
      passwordError.value = 'Senha nao pode ser vazio';
      return;
    }
    if (phone.isEmpty || !phone.isPhoneNumber) {
      phoneError.value = 'Numero de telefone não é um numero valido';
      return;
    }
    store.registerPersonal(name, email, password, phone);
  }

  @override
  void dispose() {
    nameError.dispose();
    phoneError.dispose();
    emailValidation.dispose();
    emailError.dispose();
    passwordError.dispose();
    showPassword.dispose();
  }
}
