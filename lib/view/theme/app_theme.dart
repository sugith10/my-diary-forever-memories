import 'package:flutter/material.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

abstract class AppTheme {
  final String fontFamily;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final ElevatedButtonThemeData elevatedButtonThemeData;
  final TextButtonThemeData textButtonThemeData;
  final IconButtonThemeData iconButtonThemeData;
  final DividerThemeData dividerThemeData;
  final TextSelectionThemeData textSelectionThemeData;
  final IconThemeData iconThemeData;
  final Color dialogBackgroundColor;
  final PopupMenuThemeData popupMenuThemeData;
  final BottomSheetThemeData bottomSheetThemeData;
  final FloatingActionButtonThemeData floatingActionButtonThemeData;
  AppTheme({
    required this.fontFamily,
    required this.colorScheme,
    required this.textTheme,
    required this.elevatedButtonThemeData,
    required this.textButtonThemeData,
    required this.iconButtonThemeData,
    required this.dividerThemeData,
    required this.textSelectionThemeData,
    required this.iconThemeData,
    required this.dialogBackgroundColor,
    required this.popupMenuThemeData,
    required this.bottomSheetThemeData,
    required this.floatingActionButtonThemeData,
  });
}
