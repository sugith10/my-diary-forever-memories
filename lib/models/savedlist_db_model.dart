import 'package:hive/hive.dart';
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
   List<Map<String, bool>> diaryEntryIds;

  SavedList({
    required this.id,
    required this.date,
    required this.listName,
    List<Map<String, bool>>? diaryEntryIds,
  }) : diaryEntryIds = diaryEntryIds ?? [];
  
}