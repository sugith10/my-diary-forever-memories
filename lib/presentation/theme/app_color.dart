import 'package:flutter/material.dart';

enum AppColor {
  //dark mode
  dark,
  showMenuDark,
  darkBuilder,
  darkFourth,
  //primary colors
  primary,
  secondary,
  //light mode
  light,
  showMenuLight,
}

extension AppColorExtension on AppColor {
  Color get color {
    switch (this) {
      case AppColor.dark:
        return const Color.fromARGB(255, 00, 00, 00);
      case AppColor.showMenuDark:
        return const Color.fromARGB(255, 33, 33, 33);
      case AppColor.darkBuilder:
        return const  Color.fromARGB(255, 186, 186, 186);
      case AppColor.darkFourth:
        return Color.fromRGBO(186, 186, 186, 1);
      case AppColor.primary:
        return const Color(0xFF835DF1); 
      case AppColor.secondary:
        return const Color.fromARGB(255, 183, 184, 185); 
      case AppColor.light:
        return const Color.fromARGB(255, 255, 255, 255); 
      case AppColor.showMenuLight:
        return const Color.fromARGB(255, 200, 200, 200);
    }
  }
}
