import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/theme/text_styles.dart';

import '../../theme/app_theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.spacePurple,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Settings page", style: mainTextStyle)
            ],
          ),
        ),
      ),
    );
  }
}
