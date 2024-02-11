import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/theme/text_styles.dart';

import '../../theme/app_theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.spacePurple,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Profile page", style: mainTextStyle)
            ],
          ),
        ),
      ),
    );
  }
}
