import 'package:flutter/material.dart';

import '../text_styles.dart';
import 'button_styles.dart';

class DialogActionsButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  DialogActionsButton({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: elevatedButtonStyle,
        onPressed: onPressed,
        child: Text(text, style: mainTextStyle)
    );
  }
}
