import 'package:flutter/material.dart';

import '../../../../../../core/util/asset_path/app_png.dart';

class NoPhotos extends StatelessWidget {
  const NoPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppPng.emptyGallery,
        ),
        const Text(
          'No photos yet...',
          style: TextStyle(fontSize: 20),
        ),
        const Text(
          'All photos in your diary will be shown here',
          // style: TextStyle(color: AppColor.secondary.color),
        )
      ],
    );
  }
}
