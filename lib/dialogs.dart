import 'package:flutter/material.dart';

Future<dynamic>? showCustomErrDialog(Text text, BuildContext cont) {
  return showDialog(context: cont, builder: (context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Colors.red,
        content: text
    );
  });
}