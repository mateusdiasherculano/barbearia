import 'package:barbearia/app/features/register_information/presenter/register_information_controller.dart';
import 'package:barbearia/app/features/register_information/presenter/register_information_page.dart';
import 'package:barbearia/app/features/register_information/presenter/register_information_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repository/register_information_repository.dart';
import 'domain/user_case/register_information_usecase.dart';
import 'external/datasources/register_information_datasources_impl.dart';
import 'infra/datasources/register_information_datasources.dart';
import 'infra/repository/register_information_repository_impl.dart';

class RegisterModule extends Module {
  @override
  void binds(i) {
    i.addInstance<FirebaseAuth>(FirebaseAuth.instance);
    i.addInstance<FirebaseFirestore>(FirebaseFirestore.instance);
    i.addLazySingleton<RegisterInformationDataSources>(
        RegisterInformationDatasourcesImpl.new);
    i.addLazySingleton<RegisterInformationRepository>(
        RegisterPersonalRepositoryImpl.new);
    i.addLazySingleton(RegisterInformationUseCase.new);
    i.addLazySingleton(RegisterInformationStore.new);
    i.addLazySingleton(RegisterInformationController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const PersonalInformationPage());
  }
}
