import 'package:flutter/material.dart';
import 'package:todo/theme/app_theme.dart';

/*
* TODO create another styles for another states of button pressing
* */
ButtonStyle elevatedButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(AppTheme.colors.purple)
);

ButtonStyle outlinedButtonStyle = ElevatedButton.styleFrom(
  side: BorderSide(width: 2.0, color: AppTheme.colors.pinkWhite),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(32.0),
  ),
);