import 'package:diary/feature/diary/model/diary_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DiaryData {
  Future<List<DiaryModel>> getDiary() async {
    try {
      var box = await Hive.openBox<DiaryModel>("diaryBox");
      List<DiaryModel> diaryList = box.values.toList();
      box.close();
      return diaryList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addDairy(DiaryModel diaryModel) async {
    try {
      var box = await Hive.openBox<DiaryModel>("diaryBox");
      await box.add(diaryModel);
      box.close();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDiary(String key) async {
    try {
      var box = await Hive.openBox<DiaryModel>("diaryBox");
      if (box.containsKey(key)) {
        await box.delete(key);
      } else {
        box.close();
        throw Exception("Key not found");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDiary(String key, DiaryModel diaryModel) async {
    try {
      var box = await Hive.openBox<DiaryModel>("diaryBox");
      if (box.containsKey(key)) {
        await box.put(key, diaryModel);
        await box.close();
      } else {
        box.close();
        throw Exception("Key not found");
      }
    } catch (e) {
      rethrow;
    }
  }
}
