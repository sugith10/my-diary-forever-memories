import 'package:hive_flutter/hive_flutter.dart';

part 'app_preference_model.g.dart';

@HiveType(typeId : 3)
class AppPreferenceModel{
  @HiveField(0)
  final String id = "1";

  @HiveField(1)
  final bool? showwelcome;

  @HiveField(2)
  final bool? isDark;

  AppPreferenceModel({
    this.showwelcome, this.isDark,
  });
}