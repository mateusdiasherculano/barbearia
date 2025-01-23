import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';

abstract class RegisterInformationRepository {
  Future<MessageResponse> registerPersonal(
      String? name, String? email, String? password, String? phone);
}
