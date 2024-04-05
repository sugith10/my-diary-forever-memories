import 'package:diary/core/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';

class NoPhotos extends StatelessWidget {
  const NoPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              );
  }
}