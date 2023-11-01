import 'package:hive/hive.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:flutter/foundation.dart';

  final ValueNotifier<List<DiaryEntry>> diaryEntriesNotifier =
      ValueNotifier<List<DiaryEntry>>([]);

class DbFunctions{
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


















  // Future<Box<DiaryEntry>> openBox() async {
  //   final diaryBox = await Hive.openBox<DiaryEntry>('_boxName');
  //   return diaryBox;
  // }

  // Future<void> addDiaryEntry(DiaryEntry entry) async {
  //   final box = await openBox();
  //   await box.add(entry);
  //   diaryEntriesNotifier.value.add(entry); // Notify listeners
  //   diaryEntriesNotifier.notifyListeners();
  // }

  // Future<void> getDiaryEntries() async {
  //   final box = await openBox();
  //   diaryEntriesNotifier.value.clear();
  //   diaryEntriesNotifier.value.addAll(box.values);
  //   // diaryEntriesNotifier.value = box.values.toList(); // Update the ValueNotifier
  //   diaryEntriesNotifier.notifyListeners();
  // }
