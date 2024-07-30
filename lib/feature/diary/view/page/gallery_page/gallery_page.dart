import 'package:diary/core/model/diary_model/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';

import '../../../../../core/widget/custom_app_bar.dart';
import '../../widget/diary_photos.dart';
import '../../../../../core/widget/appbar_titlestyle_common.dart';
import 'widget/no_photos.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<DiaryModel>('DiaryModelBox');
    final imageCount =
        box.values.where((entry) => entry.imagePath != null).length;

    final List<String> imagePaths = box.values
        .where((entry) => entry.imagePath != null)
        .map((entry) => entry.imagePath!)
        .toList();

    return Scaffold(
      appBar: const DefaultAppBar(
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
