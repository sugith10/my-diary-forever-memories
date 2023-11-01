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

  // final ValueNotifier<List<DiaryEntry>> diaryEntriesNotifier =
  //     ValueNotifier<List<DiaryEntry>>([]);


}

class NewDat{
  List<DiaryEntry> diaryEntryNotifier = [];
 final box =  Hive.box<DiaryEntry>('_boxName');
Future  addDiaryEntry(DiaryEntry entry) async{
  final box =  Hive.box<DiaryEntry>('_boxName');
  await box.add(entry);
  diaryEntryNotifier.add(entry);

 // diaryEntriesNotifier.notifyListeners();
}

    Future  getAllDiary() async {
   final box =  Hive.box<DiaryEntry>('_boxName');
    diaryEntryNotifier.clear();
    diaryEntryNotifier.addAll(box.values);
   
   // diaryEntriesNotifier.notifyListeners();

}
}
