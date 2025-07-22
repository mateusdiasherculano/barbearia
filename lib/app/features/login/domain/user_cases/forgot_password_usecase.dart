import 'package:barbearia/app/features/login/domain/repository/login_repository.dart';

import '../../../register_information/domain/entity/user_profile_model.dart';

abstract class IExecute {
  Future<MessageResponse> call(String? email);
}

class ForgotPasswordUseCase extends IExecute {
  final LoginRepository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<MessageResponse> call(String? email) async {
    return await _repository.resetPassword(email);
  }
}
