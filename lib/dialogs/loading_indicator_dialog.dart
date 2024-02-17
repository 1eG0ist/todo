import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LoadingIndicatorDialog extends StatelessWidget {
  const LoadingIndicatorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // loading indicator variant
      backgroundColor: AppTheme.colors.spacePurple,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppTheme.colors.pinkWhite),
                ],
              )
          ),
        ),
      ),
    );
  }
}
