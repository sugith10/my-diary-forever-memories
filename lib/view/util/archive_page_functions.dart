import 'dart:io';
import 'package:diary/data/controller/database_controller/archive_db_controller.dart';
import 'package:diary/data/model/hive/archive_db_model/archive_db_model.dart';
import 'package:diary/core/theme/app_color/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../feature/navigation_menu/page/main_navigation_menu.dart';
 
final class ArchivePageUtil {
  _showOriginalImage(BuildContext context, ArchiveDiary archive) {
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

  showOriginalImage(BuildContext context, ArchiveDiary archive) {
    _showOriginalImage(context, archive);
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, ArchiveDiary archive) {
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
                    ArchiveDiaryDatabaseManager().deleteArchivedDiary(archive.id);
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

  showDeleteConfirmationDialog(BuildContext context, ArchiveDiary archive) {
    _showDeleteConfirmationDialog(context, archive);
  }


  _showMenu(BuildContext context, ArchiveDiary archive) {
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
        ArchiveDiaryDatabaseManager().moveToDiaryDB(context, archive);
        Navigator.pop(context);
      }
    });
  }

  showingMenu(BuildContext context, ArchiveDiary archive) {
    _showMenu(context, archive);
  }
}
