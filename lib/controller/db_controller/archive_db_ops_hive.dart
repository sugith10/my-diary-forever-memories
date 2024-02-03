import 'dart:developer';
import 'package:diary/controller/db_controller/diary_entry_db_ops_hive.dart';
import 'package:diary/model/archive_db_model.dart';
import 'package:diary/model/diary_entry.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ArchiveDiaryCtrl {
  final ValueNotifier<List<ArchiveDiary>> archiveDiaryNotifier =
      ValueNotifier<List<ArchiveDiary>>([]);

  final archiveBox = Hive.box<ArchiveDiary>('archiveDiaryEntryBox');

  Future<void> addArchiveDiary(
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
    final newSavedList = ArchiveDiary(
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
    await archiveBox.put(newSavedList.id, newSavedList);
    log('Created saved list successfully');

    archiveDiaryNotifier.value = archiveBox.values.toList();

    log('Updated List: ${archiveBox.values.toList()}');
  }

  List<ArchiveDiary> getAllArchiveDairy() {
    return archiveBox.values.toList();
  }

  Future<void> deleteArchive(String id) async {
    final box = Hive.box<ArchiveDiary>('archiveDiaryEntryBox');
    if (box.containsKey(id)) {
      box.delete(id);
      log('Deleted entry with ID: $id');
    } else {
      log('Entry with ID $id not found');
    }
  }

  Future<void> moveToDiary(BuildContext context, ArchiveDiary archive) async {
    log('started');
    final DiaryEntry movedEntry = DiaryEntry(
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

    
    
    DiaryEntryCtrl().addDiaryEntry(movedEntry);

    ArchiveDiaryCtrl().deleteArchive(archive.id);


  }
}
