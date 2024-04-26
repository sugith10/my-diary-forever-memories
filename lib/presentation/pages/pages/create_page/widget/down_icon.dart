import 'package:diary/presentation/pages/util/create_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CaretDownIcon extends StatelessWidget {
  const CaretDownIcon({super.key, required this.selectedColor});

  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Ionicons.caret_down_outline,
      color: CreateDiaryScreenFunctions().isColorBright(selectedColor)
          ? Colors.black
          : Colors.white,
    );
  }
}
