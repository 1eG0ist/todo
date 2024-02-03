import 'package:flutter/material.dart';
import 'package:todo/theme/app_theme.dart';
import 'package:todo/theme/gradients.dart';

GestureDetector menuCard(Icon cardIcon, Text text, Function func) {
  return GestureDetector(
    onTap: () {func();},
    child: Card(
      color: Colors.transparent,
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            gradient: darkPurpleGradient,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(
                width: 1,
                color: AppTheme.colors.black
            )
        ),
        child: FittedBox(fit: BoxFit.fill, child: cardIcon)
      ),
    ),
  );
}

/*
* Column(
          children: [
            cardIcon,
            text,
          ],
        ),
* */