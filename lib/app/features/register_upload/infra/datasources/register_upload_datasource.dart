import '../../../register_information/domain/entity/user_profile_model.dart';

abstract class RegisterUploadDatasource {
  Future<MessageResponse> saveImage(String imagePath);
}
