import 'dart:io';
import 'package:diary/core/model/diary_model/diary_model.dart';
import 'package:diary/core/util/util/individual_diary_page_util.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../widget/content.dart';
import '../widget/date.dart';
import '../widget/title.dart';

class ViewDiaryPage extends StatefulWidget {
  final DiaryModel entry;
  const ViewDiaryPage({required this.entry, super.key});

  @override
  State<ViewDiaryPage> createState() => _ViewDiaryPageState();
}

class _ViewDiaryPageState extends State<ViewDiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        children: [
          IconButton(
            onPressed: () {
              ViewDiaryPageFunctions().showingMenu(context, widget.entry);
            },
            icon: const Icon(IconlyLight.filter),
          )
        ],
      ),
     
      body: Container(
        color: ViewDiaryPageFunctions()
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
                  ViewDiaryPageFunctions()
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
