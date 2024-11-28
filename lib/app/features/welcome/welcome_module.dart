import 'package:barbearia/app/features/welcome/presenter/welcome_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WelcomeModule extends Module {
  void binds(i) {}

  void routes(r) {
    r.child('/', child: (context) => const WelcomePage());
  }
}
