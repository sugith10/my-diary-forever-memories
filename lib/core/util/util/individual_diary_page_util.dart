import 'dart:developer';
import 'dart:io';
import 'package:diary/feature/archive/data/archive_db_controller.dart';
import 'package:diary/feature/diary/data/diary_entry_db_controller.dart';
import 'package:diary/core/model/diary_model/diary_model.dart';
import 'package:diary/core/theme/app_color/app_colors.dart';
import 'package:diary/core/util/util/get_colors.dart';
import 'package:diary/core/util/util/saved_list_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../feature/navigation_menu/page/main_navigation_menu.dart';

class ViewDiaryPageFunctions {
  void _showDeleteConfirmationDialog(BuildContext context, DiaryModel entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
       
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
                  child:
                      const Text('Delete', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    DiaryModelDatabaseManager().deleteDiary(entry.id, context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainNavigationMenu()),
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

  showDeleteConfirmationDialog(BuildContext context, DiaryModel entry) {
    _showDeleteConfirmationDialog(context, entry);
  }

  void _showArchiveConfirmationDialog(BuildContext context, DiaryModel entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
    
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
                  child: const Text('Archive',
                      style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    ArchiveDiaryModelDatabaseManager().addDiaryToArchive(
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
                    DiaryModelDatabaseManager().deleteDiary(entry.id, context);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainNavigationMenu()),
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

  showArchiveConfirmationDialog(BuildContext context, DiaryModel entry) {
    _showArchiveConfirmationDialog(context, entry);
  }

  Color _hexToColor(String color, BuildContext context) {
    log('current color -> $color');
    if (color == '#FFFFFF' || color == '#000000') {
      return GetColors().getThemeColor(context);
    }
    return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Color hexToColor(String color, BuildContext context) {
    return _hexToColor(color, context);
  }

  _showOriginalImage(BuildContext context, DiaryModel entry) {
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

  showOriginalImage(BuildContext context, DiaryModel entry) {
    _showOriginalImage(context, entry);
  }

  _showMenu(BuildContext context, DiaryModel entry) {
    showMenu(
      color: Theme.of(context).brightness == Brightness.light
          ? const Color.fromARGB(255, 255, 255, 255)
          : AppDarkColor.instance.menu,
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
       
      } else if (value == 'Delete') {
        ViewDiaryPageFunctions().showDeleteConfirmationDialog(context, entry);
      } else if (value == 'Save') {
        SavedScreenFunctions().displayBottomSheet(context, entry.id);
      } else if (value == 'Archive') {
        ViewDiaryPageFunctions()
            .showArchiveConfirmationDialog(context, entry);
      }
    });
  }

  showingMenu(BuildContext context, DiaryModel entry) {
    _showMenu(context, entry);
  }
}
