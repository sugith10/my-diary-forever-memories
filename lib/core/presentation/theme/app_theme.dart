import 'package:diary/core/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
    ),
    fontFamily: 'SFPRO',
    textTheme: TextTheme(
      labelLarge: TextStyle(color: AppColor.dark.color),
      displayLarge: TextStyle(color: AppColor.dark.color),
      displayMedium: TextStyle(color: AppColor.dark.color),
      displaySmall: TextStyle(color: AppColor.dark.color),
      headlineMedium: TextStyle(color: AppColor.dark.color),
      headlineSmall: TextStyle(color: AppColor.dark.color),
      titleLarge: TextStyle(color: AppColor.dark.color),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        toolbarTextStyle: TextStyle(color: AppColor.dark.color),
        titleTextStyle: TextStyle(color: AppColor.dark.color),
        iconTheme: IconThemeData(
            color:
                AppColor.dark.color), // Color for leading icon and back button
        actionsIconTheme: IconThemeData(
            color: AppColor.dark.color), // Color for actions (icons or buttons)
        elevation: 0),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.white),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            // This is the color when the button is in the default state
            return const Color.fromARGB(255, 0, 0, 0);
          },
        ),
      ),
    ),
  );

  final ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    buttonBarTheme: const ButtonBarThemeData(),
    colorScheme: ColorScheme.dark(
      primary: AppColor.dark.color,
      background: AppColor.dark.color,
      secondary: AppColor.dark.color,
    ),
    fontFamily: 'SFPRO',
    scaffoldBackgroundColor: AppColor.dark.color,
    appBarTheme: AppBarTheme(backgroundColor: AppColor.dark.color),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 25, 25, 25)),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            // This is the color when the button is in the default state
            return const Color.fromARGB(255, 255, 255, 255);
          },
        ),
      ),
    ),
  );
}
