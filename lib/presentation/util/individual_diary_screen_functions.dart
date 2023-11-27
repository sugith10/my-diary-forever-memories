import 'package:diary/application/controllers/hive_operations.dart';
import 'package:diary/domain/models/diary_entry.dart';
import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class DiaryDetailPageFunctions {
  void _showDeleteConfirmationDialog(BuildContext context, DiaryEntry entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete Confirmation',
            style: TextStyle(
              fontSize: 27,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this?',
            style: TextStyle(fontSize: 17),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                if (entry.id != null) {
                  DbFunctions().deleteDiary(entry.id!);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                    ModalRoute.withName('/main'),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  showDeleteConfirmationDialog(BuildContext context, DiaryEntry entry){
    _showDeleteConfirmationDialog(context, entry);
  }

  Color _hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

  Color hexToColor(String code){
    return  _hexToColor(code);
  }
}
