import 'package:flutter/material.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/pages/menu.dart';

void main() {
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

