import 'package:diary/data/model/hive/hive_database_model/diary_entry_db_model/diary_entry.dart';
import 'package:diary/presentation/pages/pages/gallery_page/widget/diary_photos.dart';
import 'package:diary/presentation/pages/pages/gallery_page/widget/no_photos.dart';
import 'package:diary/presentation/pages/pages/widget/appbar_titlestyle_common.dart';
import 'package:diary/presentation/pages/pages/widget/appbar_bottom_common.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';

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
