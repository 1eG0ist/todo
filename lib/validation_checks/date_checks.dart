import 'package:flutter/material.dart';

// TODO maybe find package with better validation

bool isValidDateDMY(String text) {
  try {
    List<String> numbers = text.split(".");
    if (
      numbers.length != 3 ||
      int.tryParse(numbers[0])! > 31 ||
      int.tryParse(numbers[0])! < 1 ||
      int.tryParse(numbers[1])! > 12 ||
      int.tryParse(numbers[1])! < 1 ||
      int.tryParse(numbers[2])! > 2500 ||
      int.tryParse(numbers[2])! < 1900
    ) {
      return false;
    }
  } catch (e) {
    return false;
  }
  return true;
}