import 'dart:developer';
import 'package:diary/controller/database_controller/diary_entry_db_controller.dart';
import 'package:diary/features/archive_diary/model/archive_db_model/archive_db_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

/// Manages interactions with the Hive database for archived diary entries.
final class ArchiveDiaryDatabaseManager {
  /// Notifier for changes in the list of archived diaries.
  final ValueNotifier<List<ArchiveDiary>> archiveDiaryNotifier =
      ValueNotifier<List<ArchiveDiary>>([]);

  /// Hive box for storing archived diary entries.
  final archiveBox = Hive.box<ArchiveDiary>('archiveDiaryBox');

  /// Moves a diary entry to the archived diaries database.
    Future<void> addDiaryToArchive(
    String? imagePath,
    String? imagePathTwo,
    String? imagePathThree,
    String? imagePathFour,
    String? imagePathFive, {
    required String id,
    required DateTime date,
    required String background,
    required String title,
    required String content,
  }) async {
    final newArchiveDiary = ArchiveDiary(
      id: id,
      date: date,
      background: background,
      title: title,
      content: content,
      imagePath: imagePath,
      imagePathTwo: imagePathTwo,
      imagePathThree: imagePathThree,
      imagePathFour: imagePathFour,
      imagePathFive: imagePathFive,
    );

    await archiveBox.put(newArchiveDiary.id, newArchiveDiary);
    log('Added diary to the archive database. ID: ${newArchiveDiary.id}');

    archiveDiaryNotifier.value = archiveBox.values.toList();
    log('Updated archived diary list: ${archiveBox.values.toList()}');
  }

  /// Deletes an archived diary by ID.
  Future<void> deleteArchivedDiary(String id) async {
    if (archiveBox.containsKey(id)) {
      archiveBox.delete(id);
      log('Deleted archived diary with ID: $id');
    } else {
      log('Archived diary with ID $id not found');
    }
  }

  /// Moves an archived diary back to the main diary entry database.
  Future<void> moveToDiaryDB(BuildContext context, ArchiveDiary archive) async {
    log('Started moving archived diary to main diary database');
    // Adding the diary to the main diary entry database.
    DiaryEntryDatabaseManager().addDiaryEntry(
      id: archive.id,
      date: archive.date,
      background: archive.background,
      title: archive.title,
      content: archive.content,
      imagePath: archive.imagePath,
      imagePathTwo: archive.imagePathTwo,
      imagePathThree: archive.imagePathThree,
      imagePathFour: archive.imagePathFour,
      imagePathFive: archive.imagePathFive,
    );

    // Deleting the archived diary from the archive database.
    deleteArchivedDiary(archive.id);
    log('Moved archived diary successfully');
  }
}
