import 'package:barbearia/app/features/log_in/domain/repository/login_repository.dart';
import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';

abstract class IExecute {
  Future<UserProfileModel> call(String? email, String? password);
}

class LoginUseCase extends IExecute {
  final LoginRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<UserProfileModel> call(String? email, String? password) async {
    return await _repository.login(email, password);
  }
}
