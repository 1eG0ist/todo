import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo/theme/text_styles.dart';

import '../theme/app_theme.dart';

class ConfirmationDialog {
  static Future<bool> showConfirmationDialog(BuildContext context, String message) async {
    Completer<bool> completer = Completer<bool>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvoked : (didPop) {
            if (didPop) {
              return;
            }
            completer.complete(false);
            Navigator.of(context).pop();
          },
          child: AlertDialog(
            backgroundColor: AppTheme.colors.spacePurple,
            title: Text('Сonfirmation', style: mainTextStyle),
            content: Text(message, style: mainTextStyle),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  completer.complete(true);
                  Navigator.of(context).pop();
                },
                child: Text('Continue', style: mainTextStyle),
              ),
              TextButton(
                onPressed: () {
                  completer.complete(false);
                  Navigator.of(context).pop();
                },
                child: Text('Close', style: mainTextStyle),
              ),
            ],
          ),
        );
      },
    );

    return completer.future;
  }
}
