import 'dart:io';
import 'package:diary/controllers/archive_db_ops_hive.dart';
import 'package:diary/controllers/diary_entry_db_ops_hive.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/presentation/screens/edit_diary_screen/edit_diary_screen.dart';
import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:diary/presentation/theme/app_color.dart';
import 'package:diary/presentation/util/saved_list_functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DiaryDetailPageFunctions {
  void _showDeleteConfirmationDialog(BuildContext context, DiaryEntry entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColor.light.color
              : AppColor.showMenuDark.color,
          title: const Center(
            child: Text(
              'Delete Confirmation',
              style: TextStyle(
                fontSize: 27,
              ),
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this?',
            style: TextStyle(fontSize: 17),
          ),
          actions: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
                TextButton(
                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    
                      DiaryEntryCtrl().deleteDiary(entry.id);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                        ModalRoute.withName('/main'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                  content: Text(
                    "Successfully Deleted",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
                    
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  showDeleteConfirmationDialog(BuildContext context, DiaryEntry entry) {
    _showDeleteConfirmationDialog(context, entry);
  }

  void _showArchiveConfirmationDialog(BuildContext context, DiaryEntry entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColor.light.color
              : AppColor.showMenuDark.color,
          title: const Center(
            child: Text(
              'Archive This Diary',
              style: TextStyle(
                fontSize: 27,
              ),
            ),
          ),
          content: const Text(
            'Are you sure you want to archive this?',
            style: TextStyle(fontSize: 17),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
              child: const Text('Archive', style: TextStyle(color: Colors.red)),
              onPressed: () {
                
                  ArchiveDiaryCtrl().addArchiveDiary(
                    id: entry.id,
                    date: entry.date,
                    background: entry.background,
                    title: entry.title,
                    content: entry.content,
                    entry.imagePath,
                    entry.imagePathTwo,
                    entry.imagePathThree,
                    entry.imagePathFour,
                    entry.imagePathFive,
                  );
                  DiaryEntryCtrl().deleteDiary(entry.id);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                    ModalRoute.withName('/main'),
                  );
                
              },
            ),

              ],
            ),
            
          ],
        );
      },
    );
  }

  showArchiveConfirmationDialog(BuildContext context, DiaryEntry entry){
    _showArchiveConfirmationDialog(context, entry);
  }

  Color _hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Color hexToColor(String code) {
    return _hexToColor(code);
  }

  _showOriginalImage(BuildContext context, DiaryEntry entry) {
    if (entry.imagePath != null) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Image.file(
              File(entry.imagePath!),
              fit: BoxFit.contain,
            ),
          );
        },
      );
    }
  }

  showOriginalImage(BuildContext context, DiaryEntry entry) {
    _showOriginalImage(context, entry);
  }

  _showMenu(BuildContext context, DiaryEntry entry) {
    showMenu(
      color: Theme.of(context).brightness == Brightness.light
          ? const Color.fromARGB(255, 255, 255, 255)
          : AppColor.showMenuDark.color,
      context: context,
      position: const RelativeRect.fromLTRB(1, 0, 0, 5),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          value: 'Delete',
          child: Row(
            children: [
              const Icon(Icons.delete_outline_rounded),
              SizedBox(
                width: 3.w,
              ),
              const Text('Delete'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Edit',
          child: Row(
            children: [
              const Icon(Icons.edit_outlined),
              SizedBox(
                width: 3.w,
              ),
              const Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Save',
          child: Row(
            children: [
              const Icon(Icons.bookmark_outline_sharp),
              SizedBox(
                width: 3.w,
              ),
              const Text('Save'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Archive',
          child: Row(
            children: [
              const Icon(Icons.archive_outlined),
              SizedBox(
                width: 3.w,
              ),
              const Text('Archive'),
            ],
          ),
        ),
        //  PopupMenuItem(
        //   value: 'Share',
        //   child: Row(
        //     children: [
        //       const Icon(Icons.share_outlined),
        //       SizedBox(
        //         width: 3.w,
        //       ),
        //       const Text('Share'),
        //     ],
        //   ),
        // ),
      ],
    ).then((value) {
      if (value == 'Edit') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditDiaryEntryScreen(
                      entry: entry,
                    )));
      } else if (value == 'Delete') {
        DiaryDetailPageFunctions().showDeleteConfirmationDialog(context, entry);
      } else if (value == 'Save') {
        SavedScreenFunctions().displayBottomSheet(context, entry.id);
      } else if (value == 'Archive') {
        DiaryDetailPageFunctions().showArchiveConfirmationDialog(context, entry);
      }
    });
  }

  showingMenu(BuildContext context, DiaryEntry entry) {
    _showMenu(context, entry);
  }
}
