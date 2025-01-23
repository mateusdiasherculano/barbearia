import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../domain/user_case/register_information_usecase.dart';

class RegisterInformationStore extends Store<MessageResponse> {
  final RegisterInformationUseCase _useCase;
  RegisterInformationStore(this._useCase) : super(MessageResponse());

  Future<void> registerPersonal(
      String name, String email, String password, String phone) async {
    return execute(() => _useCase.call(name, email, password, phone));
  }
}
