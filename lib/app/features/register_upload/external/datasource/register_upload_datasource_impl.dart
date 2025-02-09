import 'dart:io';

import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../infra/datasources/register_upload_datasource.dart';

class RegisterUploadDatasourceImpl extends RegisterUploadDatasource {
  final FirebaseStorage _firebaseStorage = Modular.get();
  final FirebaseFirestore _firebaseFirestore = Modular.get();
  final FirebaseAuth _auth = Modular.get();

  @override
  Future<UserProfileModel> saveImage(String imagePath) async {
    try {
      // Obtem o usuario autenticado
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("Usuario não autenticado");
      }

      // Define o caminho para salvar a imagem no firebase Storage
      final storageRef =
          _firebaseStorage.ref().child("user_images").child("${user.uid}.jpg");
      final uploadImage = await storageRef.putFile(File(imagePath));
      final imageUrl = await uploadImage.ref.getDownloadURL();

      final userProfileRef =
          _firebaseFirestore.collection("Users").doc(user.uid);
      final docSnapshot = await userProfileRef.get();

      if (!docSnapshot.exists) {
        throw Exception("Documento do usuário não encontrado no Firestore");
      }
      await userProfileRef.update({'image_url': imageUrl});

      // Recupera o documento atualizado
      final updateDoc = await userProfileRef.get();
      final updateData = updateDoc.data();

      if (updateData == null) {
        throw Exception("Erro ao obter dados atualizados do firestore");
      }

      // Retorna o modelo atualizado
      return UserProfileModel.fromJson(updateData);
    } catch (e) {
      throw Exception("Erro ao salvar imagem: $e");
    }
  }
}
