import 'package:diary/feature/auth/model/app_preference_model/app_preference_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Manages interactions with the Hive database for UserModel app preferences.
final class AppPrefRepo {
  final Box<AppPreferenceModel> _box;

  /// Creates an instance of [AppPrefRepo].
  AppPrefRepo() : _box = Hive.box<AppPreferenceModel>('AppPreferenceModelBox');

  /// Adds the theme preference to the AppPreferenceModel database.
  Future<void> addThemePreference(AppPreferenceModel isDark) async {
    await _box.put(isDark.id, isDark);
  }

  /// Retrieves the current theme preference from the AppPreferenceModel database.
  Future<AppPreferenceModel?> getThemePreference() async => _box.get('1');

  /// Saves the welcome screen status to the AppPreferenceModel database.
  Future<void> showwelcome(AppPreferenceModel showwelcome) async {
    await _box.put(showwelcome.id, showwelcome);
   
  }

  /// Retrieves the welcome screen status from the AppPreferenceModel database.
  Future<AppPreferenceModel?> getwelcomeStatus() async => _box.get('1');
}
