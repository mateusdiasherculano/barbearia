import 'package:barbearia/app/features/login/domain/repository/login_repository.dart';
import 'package:barbearia/app/features/login/domain/user_cases/login_usecase.dart';
import 'package:barbearia/app/features/login/external/datasource/login_datasource_impl.dart';
import 'package:barbearia/app/features/login/infra/datasources/login_datasource.dart';
import 'package:barbearia/app/features/login/infra/repository/login_repository_impl.dart';
import 'package:barbearia/app/features/login/presenter/forgot_password_controller.dart';
import 'package:barbearia/app/features/login/presenter/forgot_password_page.dart';
import 'package:barbearia/app/features/login/presenter/forgot_password_store.dart';
import 'package:barbearia/app/features/login/presenter/log_in_page.dart';
import 'package:barbearia/app/features/login/presenter/log_in_store.dart';
import 'package:barbearia/app/features/login/presenter/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/user_cases/forgot_password_usecase.dart';

class LoginModule extends Module {
  void binds(i) {
    i.addInstance<FirebaseAuth>(FirebaseAuth.instance);
    i.addLazySingleton<LoginDatasource>(LoginDatasourceImpl.new);
    i.addLazySingleton<LoginRepository>(LoginRepositoryImpl.new);
    i.addLazySingleton(LoginUseCase.new);
    i.addLazySingleton(LoginStore.new);
    i.addLazySingleton(LoginController.new);
    i.addLazySingleton(ForgotPasswordUseCase.new);
    i.addLazySingleton(ForgotPasswordStore.new);
    i.addLazySingleton(ForgotPasswordController.new);
  }

  void routes(r) {
    r.child('/', child: (context) => const LoginPage());
    r.child('/forgot_password', child: (context) => const ForgotPasswordPage());
  }
}
