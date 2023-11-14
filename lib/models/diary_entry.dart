import 'package:hive/hive.dart';
part 'diary_entry.g.dart';


@HiveType(typeId: 0)
class DiaryEntry { 

  @HiveField(0)
  String? id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String title;

  @HiveField(3)
  String content;

  @HiveField(4)
  String? imagePath; 

  @HiveField(5) 
  String? newField;

  DiaryEntry({
    this.id,
    required this.date,
    required this.title,
    required this.content,
    this.imagePath, 
    this.newField,
  });
}

