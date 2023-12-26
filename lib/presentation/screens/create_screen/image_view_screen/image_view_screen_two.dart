import 'dart:io';
import 'package:diary/presentation/util/create_screen_ctrl.dart';
import 'package:flutter/material.dart';

class FullScreenImageDialog extends StatelessWidget {
  final File imageFile;

  const FullScreenImageDialog({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CreateScreenCtrl().getImageDimensions(imageFile) ,
      builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          Size imageSize = snapshot.data!;
          return Dialog(
            child: Container(
              width: imageSize.width,
              height: imageSize.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(imageFile),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
