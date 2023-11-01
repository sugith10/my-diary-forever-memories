import 'package:hive/hive.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DiaryEntryProvider with ChangeNotifier {
  final String _boxName = 'diary_entries';
  late List<DiaryEntry> diaryEntries;

  DiaryEntryProvider() {
    diaryEntries = [];
    // Initialize diaryEntries by loading data from Hive
    getDiaryEntries();
  }

  Future<Box<DiaryEntry>> openBox() async {
    final diaryBox = await Hive.openBox<DiaryEntry>(_boxName);
    return diaryBox;
  }

  Future<void> getDiaryEntries() async {
    final box = await openBox();
    diaryEntries = box.values.toList();
    notifyListeners(); // Notify listeners after updating the data
  }

  Future<void> addDiaryEntry(DiaryEntry entry) async {
    final box = await openBox();
    await box.add(entry);
    getDiaryEntries(); // Refresh the data after adding a new entry
  }
}
