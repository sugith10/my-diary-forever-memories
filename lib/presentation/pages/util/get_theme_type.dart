import 'package:flutter/material.dart';

bool isDark(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}
