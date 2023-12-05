import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:diary/core/models/diary_entry.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


final ValueNotifier<List<DiaryEntry>> diaryEntriesNotifier =
    ValueNotifier<List<DiaryEntry>>([]);

class DbFunctions {
  List<DiaryEntry> diaryEntryNotifier = [];
  final box = Hive.box<DiaryEntry>('_boxName');
  
  Future addDiaryEntry(DiaryEntry entry) async {
    final box = Hive.box<DiaryEntry>('_boxName');
    await box.put(entry.id, entry);
    diaryEntryNotifier.add(entry);
  }

  Future getAllDiary() async {
    final box = Hive.box<DiaryEntry>('_boxName');
    diaryEntryNotifier.clear();
    diaryEntryNotifier.addAll(box.values);
  }

  Future<void> deleteDiary(String id) async {
  final box = Hive.box<DiaryEntry>('_boxName');
  if (box.containsKey(id)) {
    box.delete(id);
    log('Deleted entry with ID: $id');
  } else {
    log('Entry with ID $id not found');
  }
}

Future<void> updateDiaryEntry(DiaryEntry entry) async {
    final box = Hive.box<DiaryEntry>('_boxName');
    if (box.containsKey(entry.id)) {
      await box.put(entry.id, entry);
      log('Updated entry with ID: ${entry.id}');
    } else {
      log('Entry with ID ${entry.id} not found, cannot update.');
    }
  }

  Future<void> backupDiaryEntries(context) async {
    log('backup fuction started');
  final box = Hive.box<DiaryEntry>('_boxName');
  final diaryEntries = box.values.toList();
  final directory = await getApplicationDocumentsDirectory();
  final backupFile = File('${directory.path}/diary_backup.json');
  final jsonString = jsonEncode(diaryEntries.map((entry) => entry.toJson()).toList());
  await backupFile.writeAsString(jsonString);

  try {
    await backupFile.writeAsString(jsonString);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromRGBO(76, 175, 80, 1),
      content: Text('Diary entries successfully backed up!', style: TextStyle(color: Colors.white),),
    ));
    log('backup completed');
  } catch (error) {
    log('Error backing up diary entries: ${error.toString()}');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromRGBO(244, 67, 54, 1),
      content: Text('Error backing up diary entries. Please try again later.'),
    ));
  }
}


// Future<void> backupDiaryEntries(context) async {
//   log('Backup function started');

//   // Check for storage permission
//   final status = await Permission.storage.request();
//   if (!status.isGranted) {
//     // Show explanation or open settings
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Color.fromRGBO(244, 67, 54, 1),
//       content: Text('Please grant storage permission to backup diary entries.'),
//     ));
//     return;
//   }

//   // Get available storage locations
//    final locations = await getExternalStorageDirectories();

//   if (locations == null || locations.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Color.fromRGBO(244, 67, 54, 1),
//       content: Text('No external storage found.'),
//     ));
//     return;
//   }

//   // Show storage selection dialog
//   final selectedLocation = await showStorageSelectionDialog(context, locations);
//   if (selectedLocation == null) return;

//   // Get diary entries and create backup file path
//   final box = Hive.box<DiaryEntry>('_boxName');
//   final diaryEntries = box.values.toList();
//   final backupFile = File('${selectedLocation.path}/diary_backup.json');

//   // Convert entries to JSON and write to file
//   final jsonString = jsonEncode(diaryEntries.map((entry) => entry.toJson()).toList());
//   try {
//     await backupFile.writeAsString(jsonString);
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Color.fromRGBO(76, 175, 80, 1),
//       content: Text('Diary entries successfully backed up!', style: TextStyle(color: Colors.white)),
//     ));
//     log('Backup completed');
//   } catch (error) {
//     log('Error backing up diary entries: ${error.toString()}');
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Color.fromRGBO(244, 67, 54, 1),
//       content: Text('Error backing up diary entries. Please try again later.'),
//     ));
//   }
// }

// Future<Directory?> showStorageSelectionDialog(context, List<Directory> locations) async {
//   return await showDialog<Directory>(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text('Select Backup Location'),
//       content: ListView.builder(
//         shrinkWrap: true,
//         itemCount: locations.length,
//         itemBuilder: (context, index) {
//           final location = locations[index];
//           return ListTile(
//             title: Text(location.path),
//             onTap: () => Navigator.pop(context, location),
//           );
//         },
//       ),
//     ),
//   );
// }

}
