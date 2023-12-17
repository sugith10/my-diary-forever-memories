import 'dart:developer';
import 'package:diary/models/savedlist_db_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SavedListDbFunctions {
  final ValueNotifier<List<SavedList>> savedListsNotifier =
    ValueNotifier<List<SavedList>>([]);
  final box = Hive.box<SavedList>('_savedListBoxName');

  Future<void> createSavedList(String listName) async {
    final newSavedList = SavedList(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      listName: listName,
      diaryEntryIds: [], // Initial diary entry IDs, can be null or empty
    );
    await box.put(newSavedList.id, newSavedList);
    // log('Created saved list successfully');

    savedListsNotifier.value = box.values.toList();

  }

  List<SavedList> getAllSavedLists() {
    return box.values.toList();
  }

  Future<void> deleteSavedList(String savedListId) async {
    final savedList = box.get(savedListId);
    if (savedList != null) {
      await box.delete(savedListId);
      savedListsNotifier.value = box.values.toList();
    } else {
      // log('SavedList with ID $savedListId not found.');
    }
  }

  Future<void> addMapToDiaryEntryIds(String savedListId, String diary) async {
    final savedList = box.get(savedListId);
    if (savedList != null) {
      savedList.diaryEntryIds.add(diary);
      await box.put(savedListId, savedList);
      // log('Added map to diaryEntryIds in SavedList: $diary');
    } else {
      // log('SavedList with ID $savedListId not found.');
    }
  }

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

  bool isDiaryEntryInSavedList(String savedListId, String diaryEntryId) {
    final savedList = box.get(savedListId);
    return savedList?.diaryEntryIds.contains(diaryEntryId) ?? false;
  }
}
