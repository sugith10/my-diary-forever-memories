import 'package:hive/hive.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:flutter/foundation.dart';

final ValueNotifier<List<DiaryEntry>> diaryEntriesNotifier =
    ValueNotifier<List<DiaryEntry>>([]);

class DbFunctions {
  List<DiaryEntry> diaryEntryNotifier = [];
  final box = Hive.box<DiaryEntry>('_boxName');
  Future addDiaryEntry(DiaryEntry entry) async {
    final box = Hive.box<DiaryEntry>('_boxName');
    await box.put(entry.id, entry);
   
    diaryEntryNotifier.add(entry);

    // diaryEntriesNotifier.notifyListeners();
  }

  Future getAllDiary() async {
    final box = Hive.box<DiaryEntry>('_boxName');
    diaryEntryNotifier.clear();
    diaryEntryNotifier.addAll(box.values);
    // diaryEntriesNotifier.notifyListeners();
  }

  Future<void> deleteDiary(String id) async {
  final box = Hive.box<DiaryEntry>('_boxName');
  if (box.containsKey(id)) {
    box.delete(id);
    print('Deleted entry with ID: $id');
  } else {
    print('Entry with ID $id not found');
  }
}


}
