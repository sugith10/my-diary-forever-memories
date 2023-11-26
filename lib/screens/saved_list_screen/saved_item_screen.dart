import 'package:diary/controllers/hive_savedlist_db_ops.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/models/savedlist_db_model.dart';
import 'package:diary/screens/main_screen/main_screen.dart';
import 'package:diary/screens/my_diary_screen/mydiary_screen.dart';
import 'package:diary/screens/widget/back_button.dart';
import 'package:diary/screens/widget/bottomborder.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SavedItems extends StatefulWidget {
  final SavedList savedList;
  const SavedItems({required this.savedList, Key? key}) : super(key: key);

  @override
  State<SavedItems> createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
  late List<String> diaryEntryIds;

  @override
  void initState() {
    super.initState();
    diaryEntryIds = widget.savedList.diaryEntryIds;
  }

  List<DiaryEntry> getDiaryEntries(List<String> diaryEntryIds) {
    final diaryEntryBox =
        Hive.box<DiaryEntry>('_boxName'); // Use your actual box name
    return diaryEntryIds
        .map((entryId) => diaryEntryBox.get(entryId))
        .where((entry) => entry != null)
        .cast<DiaryEntry>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        actions: [
          IconButton(
            onPressed: () {
              _showDeleteConfirmationDialog(context, widget.savedList);
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
            ),
          ),
        ],
        elevation: 0,
        bottom: const BottomBorderWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<Box<DiaryEntry>>(
          valueListenable: Hive.box<DiaryEntry>('_boxName').listenable(),
          builder: (context, box, child) {
            // Fetch all diary entries
            // List<DiaryEntry> diaryEntries = box.values.toList();
            final selectedDiaryEntries = getDiaryEntries(diaryEntryIds);

            if (selectedDiaryEntries.isNotEmpty) {
              return ListView.builder(
                itemCount: selectedDiaryEntries.length,
                itemBuilder: (context, index) {
                  return DiaryEntryCard(selectedDiaryEntries[index], index);
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No diary entries found for this list.',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, SavedList savedList) {
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
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
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
                }
              },
            ),
          ],
        );
      },
    );
  }
}
