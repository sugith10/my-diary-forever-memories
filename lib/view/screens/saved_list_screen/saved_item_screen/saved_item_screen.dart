import 'package:diary/model/hive_database_model/diary_entry_db_model/diary_entry.dart';
import 'package:diary/model/hive_database_model/savedlist_db_model/savedlist_db_model.dart';
import 'package:diary/core/utils/screen_transitions/bottom_to_top.dart';
import 'package:diary/view/screens/individual_diary_screen/individual_diary_page.dart';
import 'package:diary/view/screens/widget/not_found.dart';
import 'package:diary/view/screens/widget/appbar_bottom_common.dart';
import 'package:diary/view/screens/widget/back_button.dart';
import 'package:diary/view/screens/my_diary_screen/widget/diary_card_widget/dairy_card.dart';
import 'package:diary/view/util/saved_list_functions.dart';
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
    final diaryEntryBox = Hive.box<DiaryEntry>('diaryEntryBox');
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
        title: Text(
          widget.savedList.listName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              SavedScreenFunctions()
                  .showDeleteConfirmationDialog(context, widget.savedList);
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
          valueListenable: Hive.box<DiaryEntry>('diaryEntryBox').listenable(),
          builder: (context, box, child) {
            final selectedDiaryEntries = getDiaryEntries(diaryEntryIds);
            if (selectedDiaryEntries.isNotEmpty) {
              return ListView.builder(
                itemCount: selectedDiaryEntries.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        bottomToTop(DiaryDetailPage(
                          entry: selectedDiaryEntries[index],
                        )),
                      );
                    },
                    child: DiaryCardView(entry: selectedDiaryEntries[index]),
                  );
                },
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty_area/savedlist_not_found.png.png',
                  ),
                  const NotFound(
                    message: "No diary entries found for this list.",
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
