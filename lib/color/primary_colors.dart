import 'package:flutter/material.dart';

enum AppColor {
  black,
  primary,
  secondary,
  accent,
  // Add more color options as needed
}

extension AppColorExtension on AppColor {
  Color get color {
    switch (this) {
      case AppColor.black:
        return const Color.fromARGB(255, 00, 00, 00);
      case AppColor.primary:
        return const Color(0xFF835DF1); 
      case AppColor.secondary:
        return const Color.fromARGB(255, 182, 184, 185); 
      case AppColor.accent:
        return const Color(0xFFFFC107); 
      // Add more cases for additional colors
    }
  }
}
