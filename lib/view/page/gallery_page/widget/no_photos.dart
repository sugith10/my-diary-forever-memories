import 'package:diary/view/theme/color/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../utils/assets/app_png.dart';

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
        Text(
          'All photos in your diary will be shown here',
          style: TextStyle(color: AppColor.secondary.color),
        )
      ],
    );
  }
}
