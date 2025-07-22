import 'package:barbearia/app/features/login/presenter/log_in_store.dart';
import 'package:barbearia/libraries/core/src/extension/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginController extends Disposable {
  final LoginStore store;

  LoginController(this.store);

  ValueNotifier<String?> emailError = ValueNotifier(null);
  ValueNotifier<String?> passwordError = ValueNotifier(null);
  ValueNotifier<bool?> showPassword = ValueNotifier(false);
  ValueNotifier<bool?> emailValidation = ValueNotifier(false);

  Future<void> login(String email, String password) async {
    if (email.isEmpty) {
      emailError.value = 'E-mail não pode ser vazio';
      return;
    }
    if (!email.isEmail) {
      emailError.value = 'Email não é valido.';
      return;
    }
    if (password.isEmpty) {
      passwordError.value = 'Senha nao pode ser vazia';
      return;
    }
    store.login(email, password);
  }

  @override
  void dispose() {
    emailError.dispose();
    passwordError.dispose();
    showPassword.dispose();
    emailValidation.dispose();
  }
}
