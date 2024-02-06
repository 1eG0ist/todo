import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/pages/menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.deepPurple
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => Menu(),
      '/todo': (context) => Home(),
    },
  ));
}

