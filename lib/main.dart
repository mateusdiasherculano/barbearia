import 'package:barbearia/app_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDYvEbFpxbchUDdCbXY5R7ZILmFHJ58HB8",
      appId: "1:715100984038:android:2cb069be08823477ce6127",
      messagingSenderId: "715100984038",
      projectId: "bloclogin-3f23e",
    ),
  );
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
