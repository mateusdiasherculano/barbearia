import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';

import '../../domain/repository/register_upload_repository.dart';
import '../datasources/register_upload_datasource.dart';

class RegisterUploadRepositoryImpl extends RegisterUploadRepository {
  final RegisterUploadDatasource _datasource;

  RegisterUploadRepositoryImpl(this._datasource);

  @override
  Future<UserProfileModel> getProfile() async {
    var result = await _datasource.getProfile();
    return result;
  }
}
