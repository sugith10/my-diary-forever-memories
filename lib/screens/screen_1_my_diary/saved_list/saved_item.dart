import 'package:diary/db/hive_savedlist_db_ops.dart';
import 'package:diary/models/savedlist_db_model.dart';
import 'package:diary/screens/home/mainscreen.dart';
import 'package:diary/screens/widgets/back_button.dart';
import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';

class SavedItems extends StatelessWidget {
  final SavedList savedList;

  const SavedItems({required this.savedList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        actions: [
          IconButton(
            onPressed: ()  {
             _showDeleteConfirmationDialog(context, savedList);
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.black,
            ),
          ),
        ],
        elevation: 0,
        bottom: const BottomBorderWidget(),
      ),
      body: Container(
        // Access savedList here and use its properties
        child: Center(child: Text(savedList.id)),
      ),
    );
  }
}


void _showDeleteConfirmationDialog(BuildContext context, SavedList savedList) {
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
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              if (savedList.id != null) {
               SavedListDbFunctions().deleteSavedList(savedList.id);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  ModalRoute.withName('/main'),
                );
                // Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}
