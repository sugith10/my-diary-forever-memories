import 'package:diary/data/model/hive/hive_database_model/diary_entry_db_model/diary_entry.dart';
import 'package:diary/data/model/hive/hive_database_model/savedlist_db_model/savedlist_db_model.dart';
import 'package:diary/presentation/navigation/screen_transitions/bottom_to_top.dart';
import 'package:diary/presentation/pages/pages/individual_diary_page/individual_diary_page.dart';
import 'package:diary/presentation/pages/pages/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/pages/pages/widget/back_button.dart';
import 'package:diary/presentation/pages/pages/home_page/widget/diary_card_widget/dairy_card.dart';
import 'package:diary/presentation/pages/util/saved_list_functions.dart';
import 'package:diary/presentation/utils/assets/app_png.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../widgets/empty_widget.dart';

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
              return const EmptyWidget(
                image: AppPng.emptyList,
                message: "No diary entries found for this list.",
              );
            }
          },
        ),
      ),
    );
  }
}
