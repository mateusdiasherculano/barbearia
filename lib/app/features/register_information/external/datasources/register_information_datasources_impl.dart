import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';
import 'package:barbearia/libraries/core/src/app_utils/app_utils.dart';
import 'package:barbearia/libraries/core/src/error/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../infra/datasources/register_information_datasources.dart';

class RegisterInformationDatasourcesImpl
    extends RegisterInformationDataSources {
  final FirebaseFirestore _db = Modular.get();
  final FirebaseAuth _auth = Modular.get();

  @override
  Future<RegisterResponse> registerPersonal(
      String? name, String? email, String? password, String? phone) async {
    try {
      // Criação do usuario com email e senha
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      // Criação da instancia de Profile com os dados recebidos por parametro
      Profile profile = Profile(
        uid: userCredential.user?.uid,
        name: name,
        email: email,
        password: password,
        phone: phone,
      );

      // Conversão da instancia de profile para json
      Map<String, dynamic> profileData = profile.toJson();

      // Adição do documento na coleção "Users" do Firestore
      await _db.collection("Users").add(profileData);

      // Retorno da instancia de Register com uma mensagem de sucesso
      return RegisterResponse(message: 'Dados salvos com sucesso');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw 'Verifique sua internet';
      } else {
        throw Failure(
          label: 'Datasource-signUp',
          exception: e,
          message: AppUtils.getMessage(e) ?? e.message,
        );
      }
    } on FirebaseException catch (e) {
      if (e.code == 'network-request-failed') {
        throw 'Verifique sua rede.';
      } else {
        throw Failure(
            label: 'Datasource-registerPersonal',
            exception: e,
            message: AppUtils.getFirebaseErrorMessage(e) ?? e.message);
      }
    }
  }
}
