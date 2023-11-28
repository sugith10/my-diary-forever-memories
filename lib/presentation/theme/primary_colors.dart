import 'package:flutter/material.dart';

enum AppColor {
  //dark mode
  dark,
  showMenuDark,
  primary,
  secondary,
  light,
  //light mode
}

extension AppColorExtension on AppColor {
  Color get color {
    switch (this) {
      case AppColor.dark:
        return const Color.fromARGB(255, 00, 00, 00);
        case AppColor.showMenuDark:
        return const Color.fromARGB(255, 33, 33, 33);
      case AppColor.primary:
        return const Color(0xFF835DF1); 
      case AppColor.secondary:
        return const Color.fromARGB(255, 182, 184, 185); 
      case AppColor.light:
        return Color.fromARGB(255, 255, 255, 255); 
      // Add more cases for additional colors
    }
  }
}
