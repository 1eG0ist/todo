import 'package:flutter/material.dart';

import '../dialogs/dialogs.dart';
import 'date_checks.dart';

bool checkTaskFields(String title, String text, String date, BuildContext context) {
  if (title.length < 3) {
    showCustomErrDialog("Too short title", context);
    return false;
  } else if (text.length < 10) {
    showCustomErrDialog("Too short text", context);
    return false;
  } else if (!isValidDateDMY(date)) {
    showCustomErrDialog("Something went wrong with due date field! Try again in day.month.year format", context);
    return false;
  }
  return true;
}