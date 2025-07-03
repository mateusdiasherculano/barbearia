import 'package:barbearia/app/features/barber_dashboard/presenter/barber_dashboard_page.dart';
import 'package:barbearia/app/features/barber_dashboard/presenter/scheduling_page.dart';
import 'package:barbearia/app/features/barber_dashboard/presenter/settings_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BarberDashboardModule extends Module {
  void binds(i) {}

  void routes(r) {
    r.child('/', child: (context) => const BarberDashboardPage());
    r.child('/scheduling', child: (context) => const SchedulingPage());
    r.child('/settings', child: (context) => const SettingsPage());
  }
}
