import 'dart:developer';
import 'package:diary/core/models/app_preference_db_model.dart';
import 'package:hive/hive.dart';

class AppPreferenceFunctions {
  final box = Hive.box<AppPreference>('appPreferenceBox');

  Future<void> addThemePreference(AppPreference isDark) async {
    await box.put(isDark.id, isDark);
    log('Added theme into db ${isDark.isDark}');
  }

 Future<AppPreference?> getThemePreference() async {
  final storedPreference = box.get('1');
  print( storedPreference?.isDark);
  return storedPreference;
}

 Future<void> showOnboarding(AppPreference showOnboarding) async {
  print('added false');
    await box.put(showOnboarding.id, showOnboarding);
    log('Added theme into db ${showOnboarding.showOnboarding}');
  }

   Future<AppPreference?> getOnboardingStatus() async {
  final onboarding = box.get('1');
  log('jsjahjdhhhsd');
  print( onboarding?.showOnboarding);
  return onboarding;
}


}