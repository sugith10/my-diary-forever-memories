import 'package:diary/data/model/hive/diary_entry_db_model/diary_entry.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';

import '../../../../../core/widget/app_custom_app_bar.dart';
import '../../../../../view/page/gallery_screen/widget/diary_photos.dart';
import '../../../../../view/page/widget/appbar_titlestyle_common.dart';
import 'widget/no_photos.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<DiaryEntry>('diaryEntryBox');
    final imageCount =
        box.values.where((entry) => entry.imagePath != null).length;

    final List<String> imagePaths = box.values
        .where((entry) => entry.imagePath != null)
        .map((entry) => entry.imagePath!)
        .toList();

    return Scaffold(
      appBar: const CustomAppBar(
        title: AppbarTitle(text: 'Gallery'),
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
                        return DiaryPhotos(imagePath: item as String);
                      },
                    ),
                  ],
                ),
              )
            : const NoPhotos(),
      ),
    );
  }
}
