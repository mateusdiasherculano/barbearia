import 'package:barbearia/app/features/barber_dashboard/barber_dashboard_module.dart';
import 'package:barbearia/app/features/login/log_in_module.dart';
import 'package:barbearia/app/features/welcome/welcome_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/features/register_information/register_module.dart';
import 'app/features/register_upload/register_upload_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/welcome', module: WelcomeModule());
    r.module('/login', module: LoginModule());
    r.module('/register', module: RegisterModule());
    r.module('/upload', module: RegisterUploadModule());
    r.module('/BarberDashboard', module: BarberDashboardModule());
  }
}
