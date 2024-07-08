import 'package:hive_flutter/hive_flutter.dart';

part 'theme_model.g.dart';

@HiveType(typeId: 6) 
enum ThemeModel {
  @HiveField(0)
  day,
  
  @HiveField(1)
  night,
}
