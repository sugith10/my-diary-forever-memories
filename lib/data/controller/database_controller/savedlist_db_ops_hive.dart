import 'dart:developer';
import 'package:diary/data/model/hive/hive_database_model/savedlist_db_model/savedlist_db_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Manages interactions with the Hive database for storing and managing saved lists.
final class SavedListDatabaseManager {
  /// Notifier for changes in the list of saved lists.
  final ValueNotifier<List<SavedList>> savedListsNotifier =
      ValueNotifier<List<SavedList>>([]);

  /// Hive box for storing saved lists.
  final box = Hive.box<SavedList>('savedListBoxName');

  /// Creates a new saved list with the specified name.
  Future<void> createSavedList(String listName) async {
    final newSavedList = SavedList(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      listName: listName,
      diaryEntryIds: [], // Initial diary entry IDs, can be null or empty
    );
    await box.put(newSavedList.id, newSavedList);
    savedListsNotifier.value = box.values.toList();
  }

  /// Retrieves all saved lists from the database.
  List<SavedList> getAllSavedLists() {
    return box.values.toList();
  }

  /// Deletes a saved list by its ID.
  Future<void> deleteSavedList(String savedListId) async {
    final savedList = box.get(savedListId);
    if (savedList != null) {
      await box.delete(savedListId);
      savedListsNotifier.value = box.values.toList();
    } else {
      log('SavedList with ID $savedListId not found.');
    }
  }

  /// Adds a diary entry ID to the specified saved list.
  Future<void> addMapToDiaryEntryIds(String savedListId, String diary) async {
    final savedList = box.get(savedListId);
    if (savedList != null) {
      savedList.diaryEntryIds.add(diary);
      await box.put(savedListId, savedList);
    } else {
      log('SavedList with ID $savedListId not found.');
    }
  }

  /// Deletes a diary entry from the specified saved list.
  Future<void> deleteDiaryEntry(String savedListId, String diaryEntryId) async {
    final savedList = box.get(savedListId);
    if (savedList != null) {
      savedList.diaryEntryIds.remove(diaryEntryId);
      await box.put(savedListId, savedList);
      log('Deleted diary entry $diaryEntryId from SavedList: $savedListId');
    } else {
      log('SavedList with ID $savedListId not found.');
    }
  }

  /// Checks if a diary entry is in the specified saved list.
  bool isDiaryEntryInSavedList(String savedListId, String diaryEntryId) {
    final savedList = box.get(savedListId);
    return savedList?.diaryEntryIds.contains(diaryEntryId) ?? false;
  }
}
