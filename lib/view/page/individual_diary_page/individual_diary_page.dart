import 'dart:io';
import 'package:diary/data/model/hive/diary_entry_db_model/diary_entry.dart';
import 'package:diary/view/util/individual_diary_page_util.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../core/util/asset_path/app_svg.dart';
import '../../../core/widget/app_custom_app_bar.dart';
import '../../../core/widget/svg_icon.dart';
import 'widget/content.dart';
import 'widget/date.dart';
import 'widget/title.dart';

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
      appBar: CustomAppBar(
        children: [
          IconButton(
            onPressed: () {
              DiaryDetailPageFunctions().showingMenu(context, widget.entry);
            },
            icon: const Icon(IconlyLight.filter),
          )
        ],
      ),
      body: Container(
        color: DiaryDetailPageFunctions()
            .hexToColor(widget.entry.background, context),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DiaryDate(
                date: widget.entry.date,
                backgroundColor: widget.entry.background,
              ),
            ),
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
                backgroundColor: widget.entry.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
