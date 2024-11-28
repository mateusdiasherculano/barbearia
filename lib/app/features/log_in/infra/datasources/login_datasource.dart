import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';

abstract class LoginDatasource {
  Future<UserProfileModel> login(String? email, String? password);
  Future<RegisterResponse> resetPassword(String? email);
}
