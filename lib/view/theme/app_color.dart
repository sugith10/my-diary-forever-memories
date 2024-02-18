import 'package:flutter/material.dart';

enum AppColor {
  //dark mode
  dark,
  darkCard,
  showMenuDark,
  darkBuilder,
  darkFourth,
  //primary colors
  primary,
  secondary,
  //light mode
  light,
  lightCard,
  showMenuLight,
}

extension AppColorExtension on AppColor {
  Color get color {
    switch (this) {
      //dark mode
      case AppColor.dark:
        return const Color.fromARGB(255, 00, 00, 00);
      case AppColor.darkCard:
        return const Color.fromARGB(255, 25, 25, 25);
      case AppColor.showMenuDark:
        return const Color.fromARGB(255, 33, 33, 33);
      case AppColor.darkBuilder:
        return const Color.fromARGB(255, 186, 186, 186);
      case AppColor.darkFourth:
        return const Color.fromRGBO(186, 186, 186, 1);
      //primary colors
      case AppColor.primary:
        return const Color.fromRGBO(131, 93, 241, 1);
      case AppColor.secondary:
        return const Color.fromARGB(255, 183, 184, 185);
      //light mode
      case AppColor.light:
        return const Color.fromARGB(255, 255, 255, 255);
      case AppColor.lightCard:
        return const Color.fromRGBO(255, 255, 255, 1);
      case AppColor.showMenuLight:
        return const Color.fromARGB(255, 200, 200, 200);
    }
  }
}
