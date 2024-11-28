import 'package:barbearia/app/features/log_in/domain/repository/login_repository.dart';
import 'package:barbearia/app/features/log_in/infra/datasources/login_datasource.dart';
import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource _datasource;

  LoginRepositoryImpl(this._datasource);

  @override
  Future<UserProfileModel> login(String? email, String? password) async {
    var result = await _datasource.login(email, password);
    return result;
  }

  @override
  Future<RegisterResponse> resetPassword(String? email) async {
    var result = await _datasource.resetPassword(email);
    return result;
  }
}
