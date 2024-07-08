import 'dart:developer';
import 'dart:io';
import 'package:diary/data/controller/database_controller/archive_db_controller.dart';
import 'package:diary/data/controller/database_controller/diary_entry_db_controller.dart';
import 'package:diary/data/model/hive/diary_entry_db_model/diary_entry.dart';
import 'package:diary/core/theme/app_color/app_colors.dart';
import 'package:diary/view_model/providers/calendar_scrn_prvdr.dart';
import 'package:diary/core/route/page_transition/no_movement.dart';
import 'package:diary/view/util/get_colors.dart';
import 'package:diary/view/util/saved_list_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import '../page/create_page/create_page.dart';
import '../../feature/navigation_menu/page/main_navigation_menu.dart';

class DiaryDetailPageFunctions {
  void _showDeleteConfirmationDialog(BuildContext context, DiaryEntry entry) {
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
                    DiaryEntryDatabaseManager().deleteDiary(entry.id, context);
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

  showDeleteConfirmationDialog(BuildContext context, DiaryEntry entry) {
    _showDeleteConfirmationDialog(context, entry);
  }

  void _showArchiveConfirmationDialog(BuildContext context, DiaryEntry entry) {
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
                    ArchiveDiaryDatabaseManager().addDiaryToArchive(
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
                    DiaryEntryDatabaseManager().deleteDiary(entry.id, context);

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

  showArchiveConfirmationDialog(BuildContext context, DiaryEntry entry) {
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
        final changer =
            Provider.of<CalenderPageProvider>(context, listen: false);
        changer.selectDate(entry.date);
        Navigator.of(context).push(
          noMovement(
            CreateDiaryPage(
              selectedColor: DiaryDetailPageFunctions()
                  .hexToColor(entry.background, context),
              changer: changer,
              diary: entry,
            ),
          ),
        );
      } else if (value == 'Delete') {
        DiaryDetailPageFunctions().showDeleteConfirmationDialog(context, entry);
      } else if (value == 'Save') {
        SavedScreenFunctions().displayBottomSheet(context, entry.id);
      } else if (value == 'Archive') {
        DiaryDetailPageFunctions()
            .showArchiveConfirmationDialog(context, entry);
      }
    });
  }

  showingMenu(BuildContext context, DiaryEntry entry) {
    _showMenu(context, entry);
  }
}
