import 'package:flutter/material.dart';

class IsDark {
  IsDark._();

  /// Check if the current theme is dark
  static bool check(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
