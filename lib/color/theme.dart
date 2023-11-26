import 'package:diary/color/primary_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
    ),
    fontFamily: 'SFPRO',
    textTheme: TextTheme(
      labelLarge: TextStyle(color: AppColor.black.color),
      displayLarge: TextStyle(color: AppColor.black.color),
      displayMedium: TextStyle(color: AppColor.black.color),
      displaySmall: TextStyle(color: AppColor.black.color),
      headlineMedium: TextStyle(color: AppColor.black.color),
      headlineSmall: TextStyle(color: AppColor.black.color),
      titleLarge: TextStyle(color: AppColor.black.color),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        toolbarTextStyle: TextStyle(color: AppColor.black.color),
        titleTextStyle: TextStyle(color: AppColor.black.color),
        iconTheme: IconThemeData(
            color:
                AppColor.black.color), // Color for leading icon and back button
        actionsIconTheme: IconThemeData(
            color:
                AppColor.black.color), // Color for actions (icons or buttons)
        elevation: 0),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.white));

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  buttonBarTheme: ButtonBarThemeData(),
  colorScheme: ColorScheme.dark(
    primary: AppColor.black.color,
    background: AppColor.black.color,
    secondary: AppColor.black.color,
  ),
  scaffoldBackgroundColor: AppColor.black.color,
  appBarTheme: AppBarTheme(backgroundColor: AppColor.black.color),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color.fromARGB(255, 69, 69, 69),
  ),
);
