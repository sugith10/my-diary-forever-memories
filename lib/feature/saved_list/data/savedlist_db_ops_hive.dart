import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/savedlist_model/savedlist_model.dart';

/// Manages interactions with the Hive database for storing and managing saved lists.
final class SavedListModelDatabaseManager {
  /// Notifier for changes in the list of saved lists.
  final ValueNotifier<List<SavedListModel>> savedListModelsNotifier =
      ValueNotifier<List<SavedListModel>>([]);

  /// Hive box for storing saved lists.
  final box = Hive.box<SavedListModel>('SavedListModelBoxName');

  /// Creates a new saved list with the specified name.
  Future<void> createSavedListModel(String listName) async {
    final newSavedListModel = SavedListModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      listName: listName,
      diaryIdList: [], // Initial diary entry IDs, can be null or empty
    );
    await box.put(newSavedListModel.id, newSavedListModel);
    savedListModelsNotifier.value = box.values.toList();
  }

  /// Retrieves all saved lists from the database.
  List<SavedListModel> getAllSavedListModels() {
    return box.values.toList();
  }

  /// Deletes a saved list by its ID.
  Future<void> deleteSavedListModel(String savedListModelId) async {
    final savedListModel = box.get(savedListModelId);
    if (SavedListModel != null) {
      await box.delete(savedListModelId);
      savedListModelsNotifier.value = box.values.toList();
    } else {
      log('SavedListModel with ID $savedListModelId not found.');
    }
  }

  /// Adds a diary entry ID to the specified saved list.
  Future<void> addMapTodiaryIdList(String SavedListModelId, String diary) async {
    final SavedListModel = box.get(SavedListModelId);
    if (SavedListModel != null) {
      SavedListModel.diaryIdList.add(diary);
      await box.put(SavedListModelId, SavedListModel);
    } else {
      log('SavedListModel with ID $SavedListModelId not found.');
    }
  }

  /// Deletes a diary entry from the specified saved list.
  Future<void> deleteDiaryModel(String SavedListModelId, String diaryIdList) async {
    final SavedListModel = box.get(SavedListModelId);
    if (SavedListModel != null) {
      SavedListModel.diaryIdList.remove(diaryIdList);
      await box.put(SavedListModelId, SavedListModel);
      log('Deleted diary entry $diaryIdList from SavedListModel: $SavedListModelId');
    } else {
      log('SavedListModel with ID $SavedListModelId not found.');
    }
  }

  /// Checks if a diary entry is in the specified saved list.
  bool isDiaryModelInSavedListModel(String SavedListModelId, String diaryIdList) {
    final SavedListModel = box.get(SavedListModelId);
    return SavedListModel?.diaryIdList.contains(diaryIdList) ?? false;
  }
}
