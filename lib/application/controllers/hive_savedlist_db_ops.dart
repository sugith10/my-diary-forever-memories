import 'dart:developer';


import 'package:diary/domain/models/savedlist_db_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

final ValueNotifier<List<SavedList>> savedListsNotifier =
    ValueNotifier<List<SavedList>>([]);

class SavedListDbFunctions {
  final box = Hive.box<SavedList>('_savedListBoxName');

  Future<void> createSavedList(String listname) async {
    final newSavedList = SavedList(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      listName: listname,
      diaryEntryIds: [], // Initial diary entry IDs, can be null or empty
    );
    await box.put(newSavedList.id, newSavedList);
    log('Created saved list successfully');

    savedListsNotifier.value = box.values.toList();

    log('Updated List: ${box.values.toList()}');
  }

  List<SavedList> getAllSavedLists() {
    return box.values.toList();
  }

  Future<void> addMapToDiaryEntryIds(String savedListId , String diary) async {
    final savedList = box.get(savedListId);
    if (savedList != null) {
      savedList.diaryEntryIds.add(diary);
      await box.put(savedListId, savedList);
      print('Added map to diaryEntryIds in SavedList: $diary');
    } else {
      print('SavedList with ID $savedListId not found.');
    }
  }

   Future<void> deleteDiaryEntry(String savedListId, String diaryEntryId) async {
    final savedList = box.get(savedListId);
    if (savedList != null) {
      savedList.diaryEntryIds.remove(diaryEntryId);
      print('Deleted diary entry $diaryEntryId from SavedList: $savedListId');
    } else {
      print('SavedList with ID $savedListId not found.');
    }
  }

  Future<void> deleteSavedList(String savedListId) async {
  final savedList = box.get(savedListId);
  if (savedList != null) {
    // Delete the saved list from the Hive box
    await box.delete(savedListId);
    print('Deleted saved list: $savedListId');

    // Notify listeners about the change in the saved lists
    savedListsNotifier.value = box.values.toList();
  } else {
    print('SavedList with ID $savedListId not found.');
  }
}



}
