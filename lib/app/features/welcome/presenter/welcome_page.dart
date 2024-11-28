import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: const Key('welcomeKey'),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset('assets/images/logo.png'),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/logoseta.png'),
                  const SizedBox(height: 40),
                  const Text(
                    'Reserve seu corte de cabelo\nem segundos',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Agende seu próximo corte de cabelo em alguns segundos. Reserve e gerencie facilmente seus compromissos.',
                      style: TextStyle(color: Color(0xFF9F9A9A), fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50, // Distância do fundo da tela
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      key: const Key('login_button_key'),
                      onTap: () {
                        Modular.to.pushNamed('/login');
                      },
                      child: Image.asset(
                        'assets/images/Login.png',
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      key: const Key('register_button_key'),
                      onTap: () {
                        Modular.to.pushNamed('/register');
                      },
                      child: Image.asset(
                        'assets/images/Register.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
