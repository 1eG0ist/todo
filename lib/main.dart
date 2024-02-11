import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/pages/home_page_area/home.dart';
import 'package:todo/pages/menu.dart';
import 'package:todo/pages/preload.dart';
import 'package:todo/pages/registration_area/registration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.signOut();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.deepPurple
    ),
    home: Preload(),
    // initialRoute: '/preload',
    // routes: {
    //   '/menu': (context) => Menu(),
    //   '/menu/todo': (context) => Home(),
    //   '/preload': (context) => Preload(),
    //   '/registration': (context) => Registration(),
    // },
  ));
}

