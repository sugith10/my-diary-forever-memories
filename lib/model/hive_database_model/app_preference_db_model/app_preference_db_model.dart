
import 'package:hive_flutter/hive_flutter.dart';

part 'app_preference_db_model.g.dart';

@HiveType(typeId : 3)
class AppPreference{
  @HiveField(0)
  final String id = "1";

  @HiveField(1)
  final bool? showOnboarding;

  @HiveField(2)
  final bool? isDark;

  AppPreference({
    this.showOnboarding, this.isDark,
  });
}