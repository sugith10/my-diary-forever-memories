import 'package:diary/data/model/hive/app_preference_db_model/app_preference_db_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Manages interactions with the Hive database for user app preferences.
final class AppPrefRepo {
  final Box<AppPreference> _box;

  /// Creates an instance of [AppPrefRepo].
  AppPrefRepo() : _box = Hive.box<AppPreference>('appPreferenceBox');

  /// Adds the theme preference to the AppPreference database.
  Future<void> addThemePreference(AppPreference isDark) async {
    await _box.put(isDark.id, isDark);
  }

  /// Retrieves the current theme preference from the AppPreference database.
  Future<AppPreference?> getThemePreference() async => _box.get('1');

  /// Saves the welcome screen status to the AppPreference database.
  Future<void> showwelcome(AppPreference showwelcome) async {
    await _box.put(showwelcome.id, showwelcome);
   
  }

  /// Retrieves the welcome screen status from the AppPreference database.
  Future<AppPreference?> getwelcomeStatus() async => _box.get('1');
}
