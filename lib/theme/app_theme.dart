import 'package:flutter/material.dart';
import 'package:todo/theme/colors.dart';

@immutable
class AppTheme {
   static const colors = AppColors();

   const AppTheme._();

   static ThemeData define() {
     return ThemeData(
       fontFamily: "Ubuntu",
       primaryColor: colors.spacePurple,
       colorScheme: ColorScheme.fromSwatch()
         .copyWith(
           secondary: colors.darkPurple,
           tertiary: colors.darkPink
       )

     );
   }
}