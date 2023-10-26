import 'package:hive/hive.dart';
import 'package:diary/models/diary_entry.dart';

class HiveOperations {
  final String _boxName = 'diary_entries';

  Future<Box<DiaryEntry>> openBox() async {
    final diaryBox = await Hive.openBox<DiaryEntry>(_boxName);
    return diaryBox;
  }

  Future<void> addDiaryEntry(DiaryEntry entry) async {
    final box = await openBox();
    await box.add(entry);
  }

  Future<List<DiaryEntry>> getDiaryEntries() async {
    final box = await openBox();
    return box.values.toList();
  }
}
