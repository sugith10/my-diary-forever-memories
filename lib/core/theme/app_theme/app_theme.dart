import 'package:diary/core/util/asset_path/app_font.dart';
import 'package:diary/core/theme/app_color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

@immutable
class _AppTheme {
  final String fontFamily;
  final Color scaffoldBackgroundColor;
  final AppBarTheme appBarTheme;
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
  final BottomNavigationBarThemeData bottomNavigationBarThemeData;
  final InputDecorationTheme inputDecorationThemeData;
  final ColorScheme colorScheme;
  
  const _AppTheme({
    required this.colorScheme,
    required this.fontFamily,
    required this.scaffoldBackgroundColor,
    required this.appBarTheme,
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
    required this.bottomNavigationBarThemeData,
    required this.inputDecorationThemeData
  });

  ThemeData get themeData {
    return ThemeData(
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: appBarTheme,
      textTheme: textTheme,
      elevatedButtonTheme: elevatedButtonThemeData,
      textButtonTheme: textButtonThemeData,
      iconButtonTheme: iconButtonThemeData,
      dividerTheme: dividerThemeData,
      textSelectionTheme: textSelectionThemeData,
      iconTheme: iconThemeData,
      dialogBackgroundColor: dialogBackgroundColor,
      popupMenuTheme: popupMenuThemeData,
      bottomSheetTheme: bottomSheetThemeData,
      floatingActionButtonTheme: floatingActionButtonThemeData,
      bottomNavigationBarTheme: bottomNavigationBarThemeData
      
    );
  }
}
