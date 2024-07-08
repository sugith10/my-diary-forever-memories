part of 'app_theme.dart';

class AppLightTheme {
  static final _color = AppLightColor.instance;
  static final _appTheme = _AppTheme(
    fontFamily: AppFont.outfit,
    colorScheme: ColorScheme.light(
      primary: _color.background,
    ),
    scaffoldBackgroundColor: _color.background,
    appBarTheme: AppBarTheme(
      backgroundColor: _color.background,
      foregroundColor: _color.primaryText,
      elevation: 0,
      scrolledUnderElevation: 0,
      shape: Border(
        bottom: BorderSide(
          color: _color.primaryText,
          width: .07,
        ),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w900,
        fontSize: 28.sp,
      ),
      displayMedium: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w800,
        letterSpacing: .5,
        fontSize: 25.sp,
      ),
      displaySmall: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w800,
        fontSize: 23.sp,
      ),
      headlineLarge: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 22.sp,
      ),
      headlineMedium: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
      ),
      headlineSmall: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 19.sp,
      ),
      titleLarge: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
      ),
      titleMedium: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 17.sp,
      ),
      titleSmall: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
      ),
      labelLarge: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 15.sp,
      ),
      labelMedium: TextStyle(
        color: _color.primaryText,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        color: _color.primaryText,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: _color.primaryText,
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: _color.primaryText,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      ),
    ),
    elevatedButtonThemeData: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _color.elevatedButton,
        foregroundColor: _color.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(50.sp, 50.sp),
        maximumSize: Size(500.sp, 100.sp),
        animationDuration: const Duration(milliseconds: 200),
      ),
    ),
    textButtonThemeData: const TextButtonThemeData(),
    iconButtonThemeData: const IconButtonThemeData(),
    dividerThemeData: const DividerThemeData(),
    textSelectionThemeData: TextSelectionThemeData(
      cursorColor: _color.secondaryText,
      selectionColor: _color.unfocus,
    ),
    iconThemeData:  IconThemeData(
      color: _color.primaryText,
    ),
    dialogBackgroundColor: _color.card,
    popupMenuThemeData: PopupMenuThemeData(
      color: _color.card,
      elevation: 5,
    ),
    bottomSheetThemeData: BottomSheetThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: _color.menu,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    floatingActionButtonThemeData: FloatingActionButtonThemeData(
      backgroundColor: _color.background,
      elevation: 5,
    ),
    bottomNavigationBarThemeData: BottomNavigationBarThemeData(
      backgroundColor: _color.background,
      selectedIconTheme: IconThemeData(
        color: _color.primaryText,
      ),
      unselectedIconTheme: IconThemeData(
        color: _color.primaryText,
      ),
    ),
    inputDecorationThemeData: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: _color.secondaryText,
      ),
    ),
  );

  final theme = _appTheme.themeData;
}
