import 'package:diary/core/widget/saved_list_app_bar.dart';
import 'package:diary/data/model/hive/diary_entry_db_model/diary_entry.dart';
import 'package:diary/data/model/hive/savedlist_db_model/savedlist_db_model.dart';
import 'package:diary/core/route/page_transition/bottom_to_top.dart';
import 'package:diary/view/util/saved_list_functions.dart';
import 'package:diary/core/util/asset_path/app_png.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../core/widget/empty_widget.dart';
import '../../../home/widget/diary_card_widget/dairy_card.dart';
import '../../../../view/page/individual_diary_page/individual_diary_page.dart';

class IndividualSavedListPage extends StatefulWidget {
  final SavedList savedList;
  const IndividualSavedListPage({required this.savedList, super.key});

  @override
  State<IndividualSavedListPage> createState() =>
      _IndividualSavedListPageState();
}

class _IndividualSavedListPageState extends State<IndividualSavedListPage> {
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
      appBar: SavedListAppBar(
        title: widget.savedList.listName,
        icon: Icons.delete_outline_rounded,
        callback: () {
          SavedScreenFunctions()
              .showDeleteConfirmationDialog(context, widget.savedList);
        },
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
