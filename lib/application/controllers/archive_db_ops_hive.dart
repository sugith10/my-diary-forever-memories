import 'dart:developer';

import 'package:diary/core/models/archive_db_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ArchiveFunctions {
  final ValueNotifier<List<ArchiveDiary>> archiveDiaryNotifier =
      ValueNotifier<List<ArchiveDiary>>([]);

  final box = Hive.box<ArchiveDiary>('archiveDiaryEntryBox');

  Future<void> addArchiveDiary(
    String? imagePath,
    String? imagePathTwo,
    String? imagePathThree,
    String? imagePathFour,
    String? imagePathFive, {
    required String background,
    required String title,
    required String content,
  }) async {
    final newSavedList = ArchiveDiary(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      background: background,
      title: title,
      content: content,
      imagePath: imagePath,
      imagePathTwo: imagePathTwo,
      imagePathThree: imagePathThree,
      imagePathFour: imagePathFour,
      imagePathFive: imagePathFive,
    );
    await box.put(newSavedList.id, newSavedList);
    log('Created saved list successfully');

    archiveDiaryNotifier.value = box.values.toList();

    log('Updated List: ${box.values.toList()}');
  }
}
