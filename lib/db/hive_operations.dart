import 'package:hive/hive.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:flutter/foundation.dart';

class HiveOperations extends ChangeNotifier {
  final String _boxName = 'diary_entries';
  final ValueNotifier<List<DiaryEntry>> diaryEntriesNotifier =
      ValueNotifier<List<DiaryEntry>>([]);

  Future<Box<DiaryEntry>> openBox() async {
    final diaryBox = await Hive.openBox<DiaryEntry>(_boxName);
    return diaryBox;
  }

  Future<void> addDiaryEntry(DiaryEntry entry) async {
    final box = await openBox();
    await box.add(entry);
    diaryEntriesNotifier.value.add(entry); // Notify listeners
    notifyListeners();
  }

  Future<void> getDiaryEntries() async {
    final box = await openBox();
    diaryEntriesNotifier.value = box.values.toList(); // Update the ValueNotifier
  }

}
