import 'package:diary/core/widget/saved_list_app_bar.dart';
import 'package:diary/core/model/diary_model/diary_model.dart';

import 'package:diary/core/route/page_transition/bottom_to_top.dart';
import 'package:diary/core/util/util/saved_list_functions.dart';
import 'package:diary/core/util/asset_path/app_png.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../core/widget/empty_widget.dart';
import '../../../home/widget/diary_card_widget/dairy_card.dart';
import '../../../saved_list/model/savedlist_model/savedlist_model.dart';
import 'individual_diary_page.dart';

class IndividualSavedListModelPage extends StatefulWidget {
  final SavedListModel savedListModel;
  const IndividualSavedListModelPage({required this.savedListModel, super.key});

  @override
  State<IndividualSavedListModelPage> createState() =>
      _IndividualSavedListModelPageState();
}

class _IndividualSavedListModelPageState extends State<IndividualSavedListModelPage> {
  late List<String> diaryIdList;

  @override
  void initState() {
    super.initState();
    diaryIdList = widget.savedListModel.diaryIdList;
  }

  List<DiaryModel> getDiaryEntries(List<String> diaryIdList) {
    final DiaryModelBox = Hive.box<DiaryModel>('DiaryModelBox');
    return diaryIdList
        .map((entryId) => DiaryModelBox.get(entryId))
        .where((entry) => entry != null)
        .cast<DiaryModel>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SavedListModelAppBar(
        title: widget.savedListModel.listName,
        icon: Icons.delete_outline_rounded,
        callback: () {
          SavedScreenFunctions()
              .showDeleteConfirmationDialog(context, widget.savedListModel);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<Box<DiaryModel>>(
          valueListenable: Hive.box<DiaryModel>('DiaryModelBox').listenable(),
          builder: (context, box, child) {
            final selectedDiaryEntries = getDiaryEntries(diaryIdList);
            if (selectedDiaryEntries.isNotEmpty) {
              return ListView.builder(
                itemCount: selectedDiaryEntries.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        bottomToTop(ViewDiaryPage(
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
