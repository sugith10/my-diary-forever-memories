
import 'package:diary/data/controller/database_controller/app_pref_db_controller.dart';
import 'package:diary/data/model/hive/hive_db_model/app_preference_db_model/app_preference_db_model.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  ThemeNotifier() {
    _initializeTheme();
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> _initializeTheme() async {
    final themePreference = await AppPrefDatabaseManager().getThemePreference();
    if (themePreference != null) {
      _isDarkMode = themePreference.isDark ?? false;
    } 
    notifyListeners();
  }

  Future<void> switchLight() async {
    if (_isDarkMode != false) {
      _isDarkMode = false;
      notifyListeners();
      await AppPrefDatabaseManager().addThemePreference(
        AppPreference( isDark: _isDarkMode),
      );
    }
  }

  Future<void> switchDark() async {
    if (_isDarkMode != true) {
      _isDarkMode = true;
      notifyListeners();
      await AppPrefDatabaseManager().addThemePreference(
        AppPreference(isDark: _isDarkMode),
      );
    }
  }
}
