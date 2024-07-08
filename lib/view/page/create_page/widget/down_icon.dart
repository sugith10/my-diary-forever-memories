import 'package:diary/view/util/create_screen_functions.dart';
import 'package:flutter/material.dart';


class CaretDownIcon extends StatelessWidget {
  const CaretDownIcon({super.key, required this.selectedColor});

  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Icon(
  Icons.abc,
      color: CreateDiaryScreenFunctions().isColorBright(selectedColor)
          ? Colors.black
          : Colors.white,
    );
  }
}
