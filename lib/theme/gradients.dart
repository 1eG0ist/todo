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

final attentionTodoTaskGradient = LinearGradient(
    colors: [
      AppTheme.colors.attentionRed1,
      AppTheme.colors.attentionRed2
    ]
);

final doneTodoTaskGradient = LinearGradient(
    colors: [
      AppTheme.colors.doneGreen1,
      AppTheme.colors.doneGreen2
    ]
);

final mainTextFadingGradient = LinearGradient(
  colors: [Colors.transparent, AppTheme.colors.pinkWhite],
  stops: [0.8, 1.0],
  begin: Alignment.centerRight,
  end: Alignment.center,
);