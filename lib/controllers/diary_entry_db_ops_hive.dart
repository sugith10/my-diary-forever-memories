import 'dart:developer';
import 'package:diary/models/diary_entry.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


final ValueNotifier<List<DiaryEntry>> diaryEntriesNotifier =
    ValueNotifier<List<DiaryEntry>>([]);

class DbFunctions {
  List<DiaryEntry> diaryEntryNotifier = [];
  final box = Hive.box<DiaryEntry>('_boxName');
  
  Future addDiaryEntry(DiaryEntry entry) async {
    final box = Hive.box<DiaryEntry>('_boxName');
    await box.put(entry.id, entry);
    diaryEntryNotifier.add(entry);
    log('added entry with IC: entry.id');
  }

  Future getAllDiary() async {
    final box = Hive.box<DiaryEntry>('_boxName');
    diaryEntryNotifier.clear();
    diaryEntryNotifier.addAll(box.values);
  }

  Future<void> deleteDiary(String id) async {
  final box = Hive.box<DiaryEntry>('_boxName');
  if (box.containsKey(id)) {
    box.delete(id);
    log('Deleted entry with ID: $id');
  } else {
    log('Entry with ID $id not found');
  }
}

Future<void> updateDiaryEntry(DiaryEntry entry) async {
    final box = Hive.box<DiaryEntry>('_boxName');
    if (box.containsKey(entry.id)) {
      await box.put(entry.id, entry);
      log('Updated entry with ID: ${entry.id}');
    } else {
      log('Entry with ID ${entry.id} not found, cannot update.');
    }
  }


}
