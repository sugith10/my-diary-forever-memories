import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:diary/core/models/diary_entry.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

final ValueNotifier<List<DiaryEntry>> diaryEntriesNotifier =
    ValueNotifier<List<DiaryEntry>>([]);

class DbFunctions {
  List<DiaryEntry> diaryEntryNotifier = [];
  final box = Hive.box<DiaryEntry>('_boxName');
  
  Future addDiaryEntry(DiaryEntry entry) async {
    final box = Hive.box<DiaryEntry>('_boxName');
    await box.put(entry.id, entry);
    diaryEntryNotifier.add(entry);
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

  Future<void> backupDiaryEntries(context) async {
    log('backup fuction started');
  final box = Hive.box<DiaryEntry>('_boxName');
  final diaryEntries = box.values.toList();
  final directory = await getApplicationDocumentsDirectory();
  final backupFile = File('${directory.path}/diary_backup.json');
  final jsonString = jsonEncode(diaryEntries.map((entry) => entry.toJson()).toList());
  await backupFile.writeAsString(jsonString);

  try {
    await backupFile.writeAsString(jsonString);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromRGBO(76, 175, 80, 1),
      content: Text('Diary entries successfully backed up!', style: TextStyle(color: Colors.white),),
    ));
    log('backup completed');
  } catch (error) {
    log('Error backing up diary entries: ${error.toString()}');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromRGBO(244, 67, 54, 1),
      content: Text('Error backing up diary entries. Please try again later.'),
    ));
  }
}

}
