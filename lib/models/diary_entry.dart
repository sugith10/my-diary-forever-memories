import 'package:hive/hive.dart';
part 'diary_entry.g.dart';


@HiveType(typeId: 0)
class DiaryEntry { 
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  DiaryEntry({
    required this.date,
    required this.title,
    required this.content,
  });
}
