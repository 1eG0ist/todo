import 'package:flutter/material.dart';
import 'package:todo/theme/app_theme.dart';

/*
* It is strongly recommended to use gradients only for backgrounds
* */

// recommended for use in Card classes
final darkPurpleGradient = LinearGradient(
    colors: [
      AppTheme.colors.darkPurple,
      AppTheme.colors.purple
    ], begin: Alignment.topLeft, end: Alignment.bottomRight
);