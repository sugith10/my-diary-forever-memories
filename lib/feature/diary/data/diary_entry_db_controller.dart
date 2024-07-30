import 'dart:developer';
import 'package:diary/core/model/diary_model/diary_model.dart';
import 'package:diary/core/widget/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Manages interactions with the Hive database for storing UserModel-written diary entries
final class DiaryModelDatabaseManager {
  /// Notifier for changes in the list of diary entries.
  final ValueNotifier<List<DiaryModel>> diaryEntriesNotifier =
      ValueNotifier<List<DiaryModel>>([]);

  /// List to store diary entries for internal use.
  List<DiaryModel> DiaryModelNotifier = [];

  /// Hive box for storing diary entries.
  final box = Hive.box<DiaryModel>('DiaryModelBox');

  /// Adds a new diary entry to the database.
  Future<void> addDiaryModel({
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
    final entry = DiaryModel(
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
    await _addDiaryModel(entry);
  }

  Future<void> _addDiaryModel(DiaryModel entry) async {
    await box.put(entry.id, entry);
    DiaryModelNotifier.add(entry);
    log('Added entry with ID: ${entry.id}');
  }

  /// Retrieves all diary entries from the database.
  Future<void> getAllDiary() async {
    DiaryModelNotifier.clear();
    DiaryModelNotifier.addAll(box.values);
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
     
    ).scaffoldMessenger(context);
  }

  /// Updates an existing diary entry in the database.
  Future<void> updateDiaryModel({
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
    final entry = DiaryModel(
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
    await _updateDiaryModel(entry);
  }

  
  Future<void> _updateDiaryModel(DiaryModel entry) async {
    if (box.containsKey(entry.id)) {
      await box.put(entry.id, entry);
      log('Updated entry with ID: ${entry.id}');
    } else {
      log('Entry with ID ${entry.id} not found, cannot update.');
    }
  }
}
