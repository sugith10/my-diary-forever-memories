import 'dart:developer';
import 'package:diary/features/my_diary/diary_entry_db_model/diary_entry.dart';
import 'package:diary/view/screens/widget/snackbar_message_widget.dart';
import 'package:diary/view/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Manages interactions with the Hive database for storing user-written diary entries
final class DiaryEntryDatabaseManager {
  /// Notifier for changes in the list of diary entries.
  final ValueNotifier<List<DiaryEntry>> diaryEntriesNotifier =
      ValueNotifier<List<DiaryEntry>>([]);

  /// List to store diary entries for internal use.
  List<DiaryEntry> diaryEntryNotifier = [];

  /// Hive box for storing diary entries.
  final box = Hive.box<DiaryEntry>('diaryEntryBox');

  /// Adds a new diary entry to the database.
  Future<void> addDiaryEntry({
    required String id,
    required DateTime date,
    required String background,
    required String title,
    required String content,
    String? imagePath,
    String? imagePathTwo,
    String? imagePathThree,
    String? imagePathFour,
    String? imagePathFive,
  }) async {
    final entry = DiaryEntry(
      id: id,
      date: date,
      title: title,
      content: content,
      background: background,
      imagePath: imagePath,
      imagePathTwo: imagePathTwo,
      imagePathThree: imagePathThree,
      imagePathFour: imagePathFour,
      imagePathFive: imagePathFive,
    );
    await _addDiaryEntry(entry);
  }

  Future<void> _addDiaryEntry(DiaryEntry entry) async {
    await box.put(entry.id, entry);
    diaryEntryNotifier.add(entry);
    log('Added entry with ID: ${entry.id}');
  }

  /// Retrieves all diary entries from the database.
  Future<void> getAllDiary() async {
    diaryEntryNotifier.clear();
    diaryEntryNotifier.addAll(box.values);
  }

  /// Deletes a diary entry by its ID from the database.
  Future<void> deleteDiary(String id, BuildContext context) async {
    if (box.containsKey(id)) {
      box.delete(id);
      log('Deleted entry with ID: $id');
    } else {
      log('Entry with ID $id not found');
    }
    SnackBarMessage(
      message: "Successfully Deleted",
      color: AppColor.fail.color,
    ).scaffoldMessenger(context);
  }

  /// Updates an existing diary entry in the database.
  Future<void> updateDiaryEntry({
    required String id,
    required DateTime date,
    required String background,
    required String title,
    required String content,
    String? imagePath,
    String? imagePathTwo,
    String? imagePathThree,
    String? imagePathFour,
    String? imagePathFive,
  }) async {
    final entry = DiaryEntry(
      id: id,
      date: date,
      title: title,
      content: content,
      background: background,
      imagePath: imagePath,
      imagePathTwo: imagePathTwo,
      imagePathThree: imagePathThree,
      imagePathFour: imagePathFour,
      imagePathFive: imagePathFive,
    );
    await _updateDiaryEntry(entry);
  }

  
  Future<void> _updateDiaryEntry(DiaryEntry entry) async {
    if (box.containsKey(entry.id)) {
      await box.put(entry.id, entry);
      log('Updated entry with ID: ${entry.id}');
    } else {
      log('Entry with ID ${entry.id} not found, cannot update.');
    }
  }
}
