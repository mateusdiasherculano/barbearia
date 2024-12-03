import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';

import '../../infra/datasources/register_upload_datasource.dart';

class RegisterUploadDatasourceImpl extends RegisterUploadDatasource {
  @override
  Future<UserProfileModel> saveImage(String imagePath) {
    // TODO: implement saveImage
    throw UnimplementedError();
  }
}
