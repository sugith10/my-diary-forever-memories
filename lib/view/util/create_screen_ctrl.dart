import 'dart:io';
import 'dart:ui';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';

class CreateScreenCtrl{
    Future<Size> _getImageDimensions(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(Uint8List.fromList(bytes));
    if (image != null) {
      return Size(image.width.toDouble(), image.height.toDouble());
    } else {
      return const Size(300, 300);
    }
  }
   Future<Size> getImageDimensions(File imageFile) async {
    return _getImageDimensions( imageFile);
   }
}