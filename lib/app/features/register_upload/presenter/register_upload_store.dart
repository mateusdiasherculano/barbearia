import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../domain/user_cases/register_upload_usecase.dart';

class RegisterUploadStore extends Store<MessageResponse> {
  final RegisterUploadUseCase _useCase;

  RegisterUploadStore(this._useCase) : super(MessageResponse());

  Future<void> saveImage(String imagePath) async {
    return execute(() => _useCase(imagePath));
  }
}
