import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/registration_area/registration.dart';

import 'home.dart';


class Preload extends StatelessWidget {
  const Preload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print("Zashel suda");
          if (snapshot.hasData) {
            return Home();
          } else {
            return Registration();
          }
        },
      )
    );
  }
}