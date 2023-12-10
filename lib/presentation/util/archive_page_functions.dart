import 'dart:io';

import 'package:diary/application/controllers/archive_db_ops_hive.dart';
import 'package:diary/core/models/archive_db_model.dart';
import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:diary/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ArchivePageUtil {
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
                  child:
                      const Text('Delete', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    ArchiveFunctions().deleteArchive(archive.id);
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

  showDeleteConfirmationDialog(BuildContext context, ArchiveDiary archive) {
    _showDeleteConfirmationDialog(context, archive);
  }


  _showMenu(BuildContext context, ArchiveDiary archive) {
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
        ArchiveFunctions().moveToDiary(context, archive);
        Navigator.pop(context);
      }
    });
  }

  showingMenu(BuildContext context, ArchiveDiary archive) {
    _showMenu(context, archive);
  }
}
