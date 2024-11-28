import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';

import '../repository/register_information_repository.dart';

abstract class IExecute {
  Future<RegisterResponse> call(
      String name, String email, String password, String phone);
}

class RegisterInformationUseCase extends IExecute {
  final RegisterInformationRepository _repository;

  RegisterInformationUseCase(this._repository);
  @override
  Future<RegisterResponse> call(
      String? name, String? email, String? password, String? phone) async {
    return await _repository.registerPersonal(name, email, password, phone);
  }
}
