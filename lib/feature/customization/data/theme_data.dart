import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

import '../model/theme_model.dart';

class AppThemeData {
  Future<ThemeModel> getThemePreference() async {
    try {
      final box = await Hive.openBox("themeBox");
      if (box.containsKey("theme")) {
        final ThemeModel theme = box.get("theme");
        box.close();
        return theme;
      } else {
        box.close();
        throw Exception("No theme found");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setThemePreference(ThemeModel theme) async {
    try {
      final box = await Hive.openBox("themeBox");
      await box.put("theme", theme);
      log("successfull added $theme");
      box.close();
    } catch (e) {
      rethrow;
    }
  }
}
