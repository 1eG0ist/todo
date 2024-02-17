import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

Future<dynamic>? showCustomErrDialog(String text, BuildContext cont) {
  return showDialog(context: cont, builder: (context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Colors.red,
        content: Text(text, style: mainTextStyle,)
    );
  });
}

Future<dynamic>? showLoadingIndicator(BuildContext cont) {
  return showDialog(
      context: cont,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      }
  );
}