import 'dart:io';
import 'package:diary/feature/archive/data/archive_db_controller.dart';
import 'package:diary/feature/archive/model/archive_diary_model/archive_diary_model.dart';
import 'package:diary/core/theme/app_color/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../feature/navigation_menu/page/main_navigation_menu.dart';
 
final class ArchivePageUtil {
  _showOriginalImage(BuildContext context, ArchiveDiaryModel archive) {
    if (archive.imagePath != null) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Image.file(
              File(archive.imagePath!),
              fit: BoxFit.contain,
            ),
          );
        },
      );
    }
  }

  showOriginalImage(BuildContext context, ArchiveDiaryModel archive) {
    _showOriginalImage(context, archive);
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, ArchiveDiaryModel archive) {
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
                    ArchiveDiaryModelDatabaseManager().deleteArchivedDiary(archive.id);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainNavigationMenu()),
                      ModalRoute.withName('/main'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                        content: Center(
                          child: Text(
                            "Successfully Deleted",
                            style: TextStyle(color: Colors.white),
                          ),
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

  showDeleteConfirmationDialog(BuildContext context, ArchiveDiaryModel archive) {
    _showDeleteConfirmationDialog(context, archive);
  }


  _showMenu(BuildContext context, ArchiveDiaryModel archive) {
    showMenu(
      color: Theme.of(context).brightness == Brightness.light
          ? const Color.fromARGB(255, 255, 255, 255)
          :AppDarkColor.instance.menu,
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
          value: 'Move',
          child: Row(
            children: [
              const Icon(Icons.move_to_inbox_outlined),
              SizedBox(
                width: 3.w,
              ),
              const Text('Move'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'Delete') {
        ArchivePageUtil().showDeleteConfirmationDialog(context, archive);
      } else if (value == 'Move') {
        ArchiveDiaryModelDatabaseManager().moveToDiaryDB(context, archive);
        Navigator.pop(context);
      }
    });
  }

  showingMenu(BuildContext context, ArchiveDiaryModel archive) {
    _showMenu(context, archive);
  }
}
