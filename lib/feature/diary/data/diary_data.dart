import 'dart:developer';

import 'package:diary/feature/diary/model/diary_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DiaryData {
  Future<List<DiaryModel>> getDiary() async {
    try {
      var box = Hive.box<DiaryModel>("diaryBox");
      List<DiaryModel> diaryList = box.values.toList();

      return diaryList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addDairy(DiaryModel diaryModel) async {
    try {
      log("open box ");
      var box = Hive.box<DiaryModel>("diaryBox");
      await box.add(diaryModel);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDiary(String key) async {
    try {
      var box = Hive.box<DiaryModel>("diaryBox");
      if (box.containsKey(key)) {
        await box.delete(key);
      } else {
        throw Exception("Key not found");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDiary(String key, DiaryModel diaryModel) async {
    try {
      var box = Hive.box<DiaryModel>("diaryBox");
      if (box.containsKey(key)) {
        await box.put(key, diaryModel);
      } else {
        throw Exception("Key not found");
      }
    } catch (e) {
      rethrow;
    }
  }
}
