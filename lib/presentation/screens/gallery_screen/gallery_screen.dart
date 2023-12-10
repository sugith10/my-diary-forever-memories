import 'dart:io';
import 'package:diary/core/models/diary_entry.dart';
import 'package:diary/presentation/screens/individual_diary_screen/individual_diary_page.dart';
import 'package:diary/presentation/screens/widget/appbar_titlestyle_common.dart';
import 'package:diary/presentation/screens/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/theme/app_color.dart';
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
      body: Container(
        child: imageCount > 0
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    MasonryView(
                      itemPadding: 5,
                      numberOfColumn: 2,
                      listOfItem: imagePaths,
                      itemBuilder: (dynamic item) {
                        return DiaryGalleryEntryCard(imagePath: item as String);
                      },
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty_area/photo_not_found.png',
                  ),
                  const Text('No photos yet...',style: TextStyle(
                    fontSize: 20
                  ),),
                   Text('All photos in your diary will be shown here', style: TextStyle(
                     color: AppColor.secondary.color
                  ),)
                ],
              ),
      ),
    );
  }
}

class DiaryGalleryEntryCard extends StatelessWidget {
  final String imagePath;

  const DiaryGalleryEntryCard({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final diaryEntry = Hive.box<DiaryEntry>('_boxName').values.firstWhere(
          (entry) => entry.imagePath == imagePath,
        );

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiaryDetailPage(entry: diaryEntry),
          ),
        );
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
