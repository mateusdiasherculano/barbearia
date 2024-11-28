import 'package:barbearia/shared/shared/theme/material-theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/welcome');
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
    );
  }
}
