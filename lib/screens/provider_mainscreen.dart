import 'package:diary/models/diary_entry.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../db/hive_operations.dart';

class MainScreenProvider with ChangeNotifier {
   int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
  Future  getAllDiary() async {
   final box = await Hive.openBox<DiaryEntry>('_boxName');
    diaryEntriesNotifier.value.clear();
    diaryEntriesNotifier.value.addAll( box.values);
    notifyListeners();
    diaryEntriesNotifier.notifyListeners();

}
}