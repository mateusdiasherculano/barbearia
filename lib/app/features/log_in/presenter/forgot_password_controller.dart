import 'package:barbearia/libraries/core/src/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'forgot_password_store.dart';

class ForgotPasswordController extends Disposable {
  final ForgotPasswordStore store;

  ForgotPasswordController(this.store);

  ValueNotifier<String?> emailError = ValueNotifier(null);
  ValueNotifier<bool> emailValidation = ValueNotifier(false);

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      emailError.value = 'E-mail não pode ser vazio';
      return;
    }
    if (!email.isEmail) {
      emailError.value = 'E-mail nao é valido';
    }
    store.resetPassword(email);
  }

  @override
  void dispose() {
    emailError.dispose();
    emailValidation.dispose();
  }
}
