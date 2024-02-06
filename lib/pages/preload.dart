import 'package:flutter/material.dart';
import 'package:todo/theme/app_theme.dart';

class Preload extends StatefulWidget {
  const Preload({super.key});

  @override
  State<Preload> createState() => _PreloadState();
}

class _PreloadState extends State<Preload> {

  void checkRegistration() {
    bool userRegistration = true;
    /*
    * TODO create local storage or another variant for user info, then check is user registered or no
    * */
    if (userRegistration) {
      Navigator.pushAndRemoveUntil(context, '/' as Route<Object?>, (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();

    checkRegistration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.spacePurple,
    );
  }

}

