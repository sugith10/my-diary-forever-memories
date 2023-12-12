import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SaveImage{
  Future<String?> _saveImage(File image) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final imagePath = "${appDocDir.path}/$uniqueFileName.jpg";
      await image.copy(imagePath);
      return imagePath;
    } catch (e) {
      log("Error saving image: $e");
      return null;
    }
  }

   Future<String?> saveImage(File image){
    return _saveImage(image);
   }
}