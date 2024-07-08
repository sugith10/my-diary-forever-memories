import 'package:diary/data/controller/database_controller/app_pref_db_controller.dart';
import 'package:diary/data/model/hive/app_preference_db_model/app_preference_db_model.dart';
import 'package:diary/view/theme/color/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  late Color _pageOne;
  late Color _pageTwo;
  late Color _pageThree;
  late Color _pageFour;

  ThemeProvider() {
    _initializeTheme();
  }

  bool get isDarkMode => _isDarkMode;

  Color get pageOne => _pageOne;
  Color get pageTwo => _pageTwo;
  Color get pageThree => _pageThree;
  Color get pageFour => _pageFour;

  Future<void> _initializeTheme() async {
    final themePreference = await AppPrefDatabaseManager().getThemePreference();
    if (themePreference != null) {
      _isDarkMode = themePreference.isDark ?? false;
    }
    notifyListeners();
    _pageColor();
  }

  Future<void> switchLight() async {
    if (_isDarkMode != false) {
      _isDarkMode = false;
      notifyListeners();
      await AppPrefDatabaseManager().addThemePreference(
        AppPreference(isDark: _isDarkMode),
      );
      _pageColor();
    }
  }

  Future<void> switchDark() async {
    if (_isDarkMode != true) {
      _isDarkMode = true;
      notifyListeners();
      await AppPrefDatabaseManager().addThemePreference(
        AppPreference(isDark: _isDarkMode),
      );
      _pageColor();
    }
  }

  void _pageColor() {
    if (_isDarkMode) {
      _pageOne = AppDarkColor.instance.pageOne;
      _pageTwo = AppDarkColor.instance.pageTwo;
      _pageThree = AppDarkColor.instance.pageThree;
      _pageFour = AppDarkColor.instance.pageFour;
    } else {
      _pageOne = AppDarkColor.instance.pageOne;
      _pageTwo = AppDarkColor.instance.pageTwo;
      _pageThree = AppDarkColor.instance.pageThree;
      _pageFour = AppDarkColor.instance.pageFour;
    }
  }
}
