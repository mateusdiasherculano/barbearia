import 'package:barbearia/app/features/login/infra/datasources/login_datasource.dart';
import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';
import 'package:barbearia/libraries/core/src/app_utils/app_utils.dart';
import 'package:barbearia/libraries/core/src/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginDatasourceImpl implements LoginDatasource {
  final FirebaseAuth firebaseAuth;

  LoginDatasourceImpl(this.firebaseAuth);

  @override
  Future<UserProfileModel> login(String? email, String? password) async {
    try {
      UserCredential response = await firebaseAuth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      return UserProfileModel.fromUserCredential(response);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw 'Verifique sua rede.';
      } else {
        throw Failure(
            label: 'Datasource-signIn',
            exception: e,
            message: AppUtils.getMessage(e) ?? e.message);
      }
    } catch (e) {
      throw Exception('Erro ao fazer login: $e');
    }
  }

  @override
  Future<MessageResponse> resetPassword(String? email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email!);
      return MessageResponse(
          message:
              'Enviamos uma mensagem para seu e-mail para redefinir sua senha!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw 'Verifique sua conexão de rede.';
      } else {
        throw Failure(
          label: 'Datasource-resetPassword',
          exception: e,
          message: AppUtils.getMessage(e) ?? e.message,
        );
      }
    } catch (e) {
      throw Exception('Erro ao resetar senha: $e');
    }
  }
}
