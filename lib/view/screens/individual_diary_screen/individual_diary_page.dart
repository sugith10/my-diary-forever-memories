import 'dart:io';
import 'package:diary/model/hive_database_model/diary_entry_db_model/diary_entry.dart';
import 'package:diary/view/screens/individual_diary_screen/widget/content.dart';
import 'package:diary/view/screens/individual_diary_screen/widget/date.dart';
import 'package:diary/view/screens/individual_diary_screen/widget/title.dart';
import 'package:diary/view/screens/widget/back_button.dart';
import 'package:diary/view/screens/widget/appbar_bottom_common.dart';
import 'package:diary/view/util/individual_diary_page_util.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class DiaryDetailPage extends StatefulWidget {
  final DiaryEntry entry;
  const DiaryDetailPage({required this.entry, super.key});

  @override
  State<DiaryDetailPage> createState() => _DiaryDetailPageState();
}

class _DiaryDetailPageState extends State<DiaryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: const BackButtonWidget(),
          actions: [
            IconButton(
              onPressed: () {
                DiaryDetailPageFunctions().showingMenu(context, widget.entry);
              },
              icon: const Icon(
                Ionicons.ellipsis_vertical_outline,
              ),
            )
          ],
          bottom: const BottomBorderWidget()),
      body: Container(
        color: DiaryDetailPageFunctions().hexToColor(widget.entry.background,context),
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: DiaryDate(
                  date: widget.entry.date,
                  backgroundColor: widget.entry.background,
                )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                      child: DiaryTitle(
                    title: widget.entry.title,
                    backgroundColor: widget.entry.background,
                  )),
                ],
              ),
            ),
            if (widget.entry.imagePath != null)
              GestureDetector(
                onTap: () {
                  DiaryDetailPageFunctions()
                      .showOriginalImage(context, widget.entry);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(widget.entry.imagePath!),
                      fit: BoxFit.cover,
                      height: 380,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: DiaryContent(
                  content: widget.entry.content,
                  backgroundColor: widget.entry.background,),
            ),
          ],
        ),
      ),
    );
  }
}
