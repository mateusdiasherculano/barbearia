import 'package:flutter_triple/flutter_triple.dart';

import '../../register_information/domain/entity/user_profile_model.dart';
import '../domain/user_cases/forgot_password_usecase.dart';

class ForgotPasswordStore extends Store<MessageResponse> {
  final ForgotPasswordUseCase _execute;

  ForgotPasswordStore(this._execute) : super(MessageResponse());

  Future<void> resetPassword(String? email) async {
    return execute(() => _execute.call(email));
  }
}
