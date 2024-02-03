import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class ImagePickCntrl{
    Future<String?> _saveImage(File image) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final imagePath = "${appDocDir.path}/$uniqueFileName.jpg";
      // Read and decode the original image
      final bytes = image.readAsBytesSync();
      final originalImage = img.decodeImage(Uint8List.fromList(bytes));

      // Resize the image if its height is more than 800 pixels
      if (originalImage != null && originalImage.height > 800) {
        final resizedImage = img.copyResize(originalImage, height: 800);
        File(imagePath).writeAsBytesSync(img.encodeJpg(resizedImage));
      } else {
        // Save the original image if its height is not more than 300 pixels
        image.copy(imagePath);
      }

      return imagePath;
    } catch (e) {
      log("Error saving image: $e");
      return null;
    }
  }

   Future<String?> saveImage(File image)async{
    return _saveImage(image);
   }
}