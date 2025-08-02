import 'package:flutter/material.dart';

class Utils {
  static void fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode nextFoucus,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFoucus);
  }
}
