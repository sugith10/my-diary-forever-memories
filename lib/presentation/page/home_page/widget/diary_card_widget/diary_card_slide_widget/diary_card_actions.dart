import 'package:diary/data/model/hive/hive_db_model/diary_entry_db_model/diary_entry.dart';
import 'package:diary/presentation/navigation/screen_transitions/bottom_to_top.dart';
import 'package:diary/presentation/util/individual_diary_page_util.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../individual_diary_page/individual_diary_page.dart';
import '../dairy_card.dart';

class DiaryCardActions extends StatelessWidget {
  final DiaryEntry entry;
  final int index;

  const DiaryCardActions(this.entry, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
     
        children: [
          SlidableActionWidget(
            entry: entry,
            radius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
       
        children: [
          SlidableActionWidget(
            entry: entry,
            radius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            bottomToTop(
              DiaryDetailPage(
                entry: entry,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: DiaryCardView(entry: entry),
        ),
      ),
    );
  }
}

class SlidableActionWidget extends StatelessWidget {
  const SlidableActionWidget({
    super.key,
    required this.entry,
    required this.radius,
  });

  final DiaryEntry entry;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: (BuildContext context) {
       DiaryDetailPageFunctions().showDeleteConfirmationDialog(context, entry);
      },
      borderRadius: radius,
      backgroundColor: const Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'Delete',
    );
  }
}
