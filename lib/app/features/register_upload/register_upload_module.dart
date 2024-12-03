import 'package:barbearia/app/features/register_upload/presenter/register_upload_controller.dart';
import 'package:barbearia/app/features/register_upload/presenter/register_upload_page.dart';
import 'package:barbearia/app/features/register_upload/presenter/register_upload_store.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repository/register_upload_repository.dart';
import 'domain/user_cases/register_upload_usecase.dart';
import 'external/datasource/register_upload_datasource_impl.dart';
import 'infra/datasources/register_upload_datasource.dart';
import 'infra/repository/register_upload_repository_impl.dart';

class RegisterUploadModule extends Module {
  @override
  void binds(i) {
    i.addInstance<FirebaseStorage>(FirebaseStorage.instance);
    i.addLazySingleton<RegisterUploadDatasource>(
        RegisterUploadDatasourceImpl.new);
    i.addLazySingleton<RegisterUploadRepository>(
        RegisterUploadRepositoryImpl.new);
    i.addLazySingleton(RegisterUploadUseCase.new);
    i.addLazySingleton(RegisterUploadStore.new);
    i.addLazySingleton(RegisterUploadController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const RegisterUploadPage());
  }
}
