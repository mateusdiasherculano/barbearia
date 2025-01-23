import '../../../register_information/domain/entity/user_profile_model.dart';

abstract class RegisterUploadRepository {
  Future<MessageResponse> saveImage(String imagePath);
}
