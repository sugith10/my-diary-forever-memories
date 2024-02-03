import 'package:diary/controller/app_preference_db_ops_hive.dart';
import 'package:diary/model/app_preference_db_model.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  ThemeNotifier() {
    _initializeTheme();
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> _initializeTheme() async {
    final themePreference = await AppPreferenceCtrl().getThemePreference();
    if (themePreference != null) {
      _isDarkMode = themePreference.isDark ?? false;
    } 
    notifyListeners();
  }

  Future<void> switchLight() async {
    if (_isDarkMode != false) {
      _isDarkMode = false;
      notifyListeners();
      await AppPreferenceCtrl().addThemePreference(
        AppPreference( isDark: _isDarkMode),
      );
    }
  }

  Future<void> switchDark() async {
    if (_isDarkMode != true) {
      _isDarkMode = true;
      notifyListeners();
      await AppPreferenceCtrl().addThemePreference(
        AppPreference(isDark: _isDarkMode),
      );
    }
  }
}
