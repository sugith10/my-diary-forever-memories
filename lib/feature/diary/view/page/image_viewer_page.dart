import 'dart:io';
import 'package:flutter/material.dart';

import '../../../../core/widget/custom_app_bar.dart';

class ImageViewerPage extends StatelessWidget {
  final File imageFile;

  const ImageViewerPage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: Text('Image Viewer'),
        showLeading: true,
      ),
      body: Center(
        child: Image.file(
          imageFile,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
