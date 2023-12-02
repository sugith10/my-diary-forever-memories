import 'package:hive/hive.dart';
part 'app_preference_db_model.g.dart';

@HiveType(typeId : 3)
class AppPreference{
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final bool? showOnboarding;

  @HiveField(2)
  final bool? isDark;

  AppPreference({
    this.id,  this.showOnboarding, this.isDark,
  });
}