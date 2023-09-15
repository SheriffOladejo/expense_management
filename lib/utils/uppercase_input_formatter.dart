import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UppercaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      // Ensure the first character is uppercase
      return TextEditingValue(
        text: newValue.text.capitalizeFirstLetter(),
        selection: newValue.selection,
      );
    }
    return newValue;
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}