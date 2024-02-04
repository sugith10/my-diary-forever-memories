import 'dart:developer';
import 'package:diary/model/app_preference_db_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppPreferenceCtrl {
  final box = Hive.box<AppPreference>('appPreferenceBox');

  Future<void> addThemePreference(AppPreference isDark) async {
    await box.put(isDark.id, isDark);
    log('Added theme into db ${isDark.isDark}');
  }

  Future<AppPreference?> getThemePreference() async {
    final storedPreference = box.get('1');
    return storedPreference;
  }
  
  Future<void> showOnboarding(AppPreference showOnboarding) async {
    await box.put(showOnboarding.id, showOnboarding);
    log('Added theme into db ${showOnboarding.showOnboarding}');
  }

  Future<AppPreference?> getOnboardingStatus() async {
    final onboarding = box.get('1');
    return onboarding;
  }
}
