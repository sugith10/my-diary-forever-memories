import 'package:diary/feature/diary/data/diary_data.dart';
import 'package:diary/feature/diary/model/diary_model.dart';

class DiaryRepo {
  final DiaryData _dairyData;
  DiaryRepo(this._dairyData);
  Future<List<DiaryModel>> getDiary() async {
    try {
      return _dairyData.getDiary();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addDiary(DiaryModel diaryModel) async {
    try {
      await _dairyData.addDairy(diaryModel);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDiary(String key) async {
    try {
      await _dairyData.deleteDiary(key);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDiary(String key, DiaryModel diaryModel) async {
    try {
      await _dairyData.updateDiary(key, diaryModel);
    } catch (e) {
      rethrow;
    }
  }
}
