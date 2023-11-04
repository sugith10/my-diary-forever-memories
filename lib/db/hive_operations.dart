

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
    final boxId = await box.add(entry);
    entry.id = boxId;
    diaryEntryNotifier.add(entry);

    // diaryEntriesNotifier.notifyListeners();
  }

  Future getAllDiary() async {
    final box = Hive.box<DiaryEntry>('_boxName');
    diaryEntryNotifier.clear();
    diaryEntryNotifier.addAll(box.values);
    // diaryEntriesNotifier.notifyListeners();
  }

  Future<void> deleteDiary(int id) async {
     final box = Hive.box<DiaryEntry>('_boxName');
     print('del success');
     box.delete(id);
     
  }

}
