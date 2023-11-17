import 'dart:developer';

import 'package:diary/models/savedlist_db_model.dart';
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

    Future<void> addDiaryToSavedList(String savedListId, String diaryEntryId) async {
    final savedList = box.get(savedListId);
    if (savedList != null) {
      savedList.diaryEntryIds.add(diaryEntryId);
      await box.put(savedListId, savedList);
      log('Added diary entry ID to the SavedList: $diaryEntryId');
    } else {
      log('SavedList with ID $savedListId not found.');
    }
  }


}