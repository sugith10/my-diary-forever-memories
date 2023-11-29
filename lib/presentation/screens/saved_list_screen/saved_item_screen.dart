import 'package:diary/domain/models/diary_entry.dart';
import 'package:diary/domain/models/savedlist_db_model.dart';
import 'package:diary/presentation/screens/my_diary_screen/mydiary_screen.dart';
import 'package:diary/presentation/screens/widget/back_button.dart';
import 'package:diary/presentation/screens/widget/appbar_bottom.dart';
import 'package:diary/presentation/util/saved_list_functions.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SavedItems extends StatefulWidget {
  final SavedList savedList;
  const SavedItems({required this.savedList, super.key});

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
        Hive.box<DiaryEntry>('_boxName'); 
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
              SavedScreenFunctions().showDeleteConfirmationDialog(context, widget.savedList);
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
}
