import 'package:flutter/services.dart';

class TextOnlyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.replaceAll(RegExp(r'[^a-zA-Z]'), ''),
      selection: newValue.selection,
    );
  }
}

class NumberOnlyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.replaceAll(RegExp(r'[^0-9]'), ''),
      selection: newValue.selection,
    );
  }
}
