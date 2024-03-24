import 'package:hive_flutter/hive_flutter.dart';

part 'savedlist_db_model.g.dart';

@HiveType(typeId: 2)
class SavedList {

  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String listName;

  @HiveField(3)
  List<String> diaryEntryIds;

  SavedList({
    required this.id,
    required this.date,
    required this.listName,
    List<String>? diaryEntryIds,
  }) : diaryEntryIds = diaryEntryIds ?? [];
  
}