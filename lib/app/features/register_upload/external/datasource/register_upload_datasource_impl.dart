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
  Future<MessageResponse> saveImage(String imagePath) async {
    try {
      final String userId = _auth.currentUser!.uid;

      final String saveImagePath = "user_images/$userId/profile_photo.jpg";
      final Reference imageRef = _firebaseStorage.ref(saveImagePath);
      final UploadTask imageUploadTask = imageRef.putFile(File(imagePath));
      final TaskSnapshot taskSnapshot = await imageUploadTask;

      final QuerySnapshot fetchDocId = await _firebaseFirestore
          .collection('Users')
          .where('id', isEqualTo: userId)
          .limit(1)
          .get();

      if (fetchDocId.docs.isNotEmpty) {
        final DocumentSnapshot userDoc = fetchDocId.docs.first;
        final String documentId = userDoc.id;
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        await _firebaseFirestore
            .collection('Users')
            .doc(documentId)
            .update({'image_url': downloadUrl});
      }

      return MessageResponse(message: "Imagem salva com sucesso.");
    } catch (e) {
      throw Exception("Erro ao salvar imagem: $e");
    }
  }
}
