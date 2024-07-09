import 'dart:io';

import 'package:flutter/material.dart';

class DiaryImageWidget extends StatelessWidget {
  final File? image;
  final Function(TapDownDetails) callback;
  const DiaryImageWidget({
    required this.image,
    required this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: image != null
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTapDown: (details) {
                  callback(details);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    image!,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
