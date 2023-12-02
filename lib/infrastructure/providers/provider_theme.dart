import 'package:diary/application/controllers/hive_app_preference_db_ops.dart';
import 'package:diary/core/models/app_preference_db_model.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  ThemeNotifier() {
    _initializeTheme();
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> _initializeTheme() async {
    final themePreference = await AppPreferenceFunctions().getThemePreference();
    if (themePreference != null) {
      _isDarkMode = themePreference.isDark ?? false;
    } 
    notifyListeners();
  }

  Future<void> switchLight() async {
    if (_isDarkMode != false) {
      _isDarkMode = false;
      notifyListeners();
      await AppPreferenceFunctions().addThemePreference(
        AppPreference(id: '1', isDark: _isDarkMode),
      );
    }
  }

  Future<void> switchDark() async {
    if (_isDarkMode != true) {
      _isDarkMode = true;
      notifyListeners();
      await AppPreferenceFunctions().addThemePreference(
        AppPreference(id: '1', isDark: _isDarkMode),
      );
    }
  }
}
