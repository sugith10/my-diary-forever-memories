import 'dart:developer';
import 'package:diary/data/model/hive/hive_database_model/app_preference_db_model/app_preference_db_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Manages interactions with the Hive database for user app preferences.
final class AppPrefDatabaseManager {
  final Box<AppPreference> _box;

  /// Creates an instance of [AppPrefDatabaseManager].
  AppPrefDatabaseManager() : _box = Hive.box<AppPreference>('appPreferenceBox');

  /// Adds the theme preference to the AppPreference database.
  Future<void> addThemePreference(AppPreference isDark) async {
    await _box.put(isDark.id, isDark);
     log('Theme preference added to app preference database. Theme isDark: ${isDark.isDark}');
  }

  /// Retrieves the current theme preference from the AppPreference database.
  Future<AppPreference?> getThemePreference() async => _box.get('1');

  /// Saves the onboarding screen status to the AppPreference database.
  Future<void> showOnboarding(AppPreference showOnboarding) async {
    await _box.put(showOnboarding.id, showOnboarding);
    log('Onboarding status added to app preference database. Show Onboarding: ${showOnboarding.showOnboarding}');
  }

  /// Retrieves the onboarding screen status from the AppPreference database.
  Future<AppPreference?> getOnboardingStatus() async => _box.get('1');
}
