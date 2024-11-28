import '../../../register_information/domain/entity/user_profile_model.dart';
import '../repository/register_upload_repository.dart';

abstract class IExecute {
  Future<UserProfileModel> call();
}

class RegisterUploadUseCase extends IExecute {
  final RegisterUploadRepository _repository;

  RegisterUploadUseCase(this._repository);

  @override
  Future<UserProfileModel> call() async {
    return await _repository.getProfile();
  }
}
