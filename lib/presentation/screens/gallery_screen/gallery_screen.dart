import 'dart:io';
import 'package:diary/core/models/diary_entry.dart';
import 'package:diary/presentation/screens/widget/appbar_titlestyle_common.dart';
import 'package:diary/presentation/screens/widget/appbar_bottom_common.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<DiaryEntry>('_boxName');
    final imageCount =
        box.values.where((entry) => entry.imagePath != null).length;

    final List<String> imagePaths = box.values
        .where((entry) => entry.imagePath != null)
        .map((entry) => entry.imagePath!)
        .toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const AppbarTitleWidget(text: 'Gallery'),
        elevation: 0,
        bottom: const BottomBorderWidget(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: MasonryView(
            itemPadding: 5,
            numberOfColumn: 2,
            listOfItem: imagePaths,
             itemBuilder: (dynamic item) {
              return DiaryGalleryEntryCard(imagePath: item as String);
            },
          ),
        ),
      ),
    );
  }
}

class DiaryGalleryEntryCard extends StatelessWidget {
  final String imagePath;

  const DiaryGalleryEntryCard({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle the onTap event
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(imagePath),
        ),
      ),
    );
  }
}
