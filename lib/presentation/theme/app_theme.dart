import 'package:diary/presentation/theme/app_color.dart';
import 'package:diary/presentation/theme/color/app_colors.dart';
import 'package:diary/presentation/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final _textStyle = TextStyle(color: AppColor.dark.color);
  final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
    ),
    fontFamily: MyAppFonts.sfPro,
    textTheme: TextTheme(
      labelLarge: _textStyle,
      displayLarge: _textStyle,
      displayMedium: _textStyle,
      displaySmall: _textStyle,
      headlineMedium: _textStyle,
      headlineSmall: _textStyle,
      titleLarge: _textStyle,
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
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            // This is the color when the button is in the default state
            return const Color.fromARGB(255, 0, 0, 0);
          },
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppDarkColor.instance.focus,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          textStyle: const TextStyle(
            fontFamily: MyAppFonts.satoshi,
            fontWeight: FontWeight.w600
          )),
    ),
  );

  final ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    buttonBarTheme: const ButtonBarThemeData(),
    colorScheme: ColorScheme.dark(
      primary: AppColor.dark.color,
      surface: AppColor.dark.color,
      secondary: AppColor.dark.color,
    ),
    fontFamily: MyAppFonts.sfPro,
    scaffoldBackgroundColor: AppColor.dark.color,
    appBarTheme: AppBarTheme(backgroundColor: AppColor.dark.color),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 25, 25, 25)),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            // This is the color when the button is in the default state
            return const Color.fromARGB(255, 255, 255, 255);
          },
        ),
      ),
    ),
  );
}
