import 'dart:io';
import 'package:diary/data/model/hive/hive_database_model/diary_entry_db_model/diary_entry.dart';
import 'package:diary/presentation/pages/pages/individual_diary_page/widget/content.dart';
import 'package:diary/presentation/pages/pages/individual_diary_page/widget/date.dart';
import 'package:diary/presentation/pages/pages/individual_diary_page/widget/title.dart';
import 'package:diary/presentation/pages/pages/widget/back_button.dart';
import 'package:diary/presentation/pages/pages/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/pages/util/individual_diary_page_util.dart';
import 'package:flutter/material.dart';

import '../../../utils/assets/app_svg.dart';
import '../../../widgets/svg_icon.dart';

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
              icon: const SvgIcon(path: AppSvg.more),
            )
          ],
          bottom: const BottomBorderWidget()),
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
