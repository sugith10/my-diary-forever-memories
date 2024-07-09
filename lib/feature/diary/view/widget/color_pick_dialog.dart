
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickDialog {
  ColorPickDialog._();
  static void showColorPickerDialog(
    BuildContext context,
    Color selectedColor,
    ValueChanged<Color> onColorChanged,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) => const LinearGradient(
                colors: [Colors.red, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                'Choose Background Color',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(8.0),
          shadowColor: Colors.black26,
          content: SizedBox(
            height: 220,
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
               
                onColorChanged(color);
                // Call the provided callback with the new color
              },
              availableColors: const [
                Color.fromARGB(255, 250, 240, 248),
                Color.fromARGB(255, 223, 244, 255),
                Color.fromARGB(255, 225, 223, 255),
                Color.fromARGB(255, 208, 205, 186),
                Color.fromARGB(255, 196, 204, 168),
                Color.fromARGB(255, 182, 174, 205),
                Color.fromARGB(255, 198, 185, 180),
                Color.fromARGB(255, 164, 153, 139),
                Color.fromARGB(255, 111, 98, 98),
                Color.fromARGB(255, 97, 96, 108),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Text('Cancel'),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Text(
                    'OK',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
