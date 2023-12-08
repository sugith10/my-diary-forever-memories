import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class FullScreenImageDialog extends StatelessWidget {
  final File imageFile;

  const FullScreenImageDialog({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getImageDimensions(),
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
          return Container();
        }
      },
    );
  }

  Future<Size> _getImageDimensions() async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(Uint8List.fromList(bytes));
    if (image != null) {
      return Size(image.width.toDouble(), image.height.toDouble());
    } else {
     
      return const Size(300, 300);
    }
  }
}
