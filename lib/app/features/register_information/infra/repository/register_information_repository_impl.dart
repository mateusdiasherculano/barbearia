import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';

import '../../domain/repository/register_information_repository.dart';
import '../datasources/register_information_datasources.dart';

class RegisterPersonalRepositoryImpl extends RegisterInformationRepository {
  final RegisterInformationDataSources _datasources;

  RegisterPersonalRepositoryImpl(this._datasources);
  @override
  Future<MessageResponse> registerPersonal(
      String? name, String? email, String? password, String? phone) async {
    return await _datasources.registerPersonal(name, email, password, phone);
  }
}
