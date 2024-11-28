import 'package:barbearia/app/features/log_in/domain/user_cases/login_usecase.dart';
import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';
import 'package:flutter_triple/flutter_triple.dart';

class LoginStore extends Store<UserProfileModel> {
  final LoginUseCase _useCase;

  LoginStore(this._useCase) : super(UserProfileModel());

  Future<void> login(String? email, String? password) async {
    return execute(() => _useCase.call(email, password));
  }
}
