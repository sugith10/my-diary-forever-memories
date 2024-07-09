import 'package:diary/core/theme/app_color/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../view/util/create_screen_functions.dart';

class CreateDairyTextField extends StatelessWidget {
  const CreateDairyTextField({
    super.key,
    required  this. controller,
    required this.capitalization,
    required this.background,
    required this.hintText,
    required this.fontSize,
  });

  final TextEditingController controller;
  final TextCapitalization capitalization; 
  final String hintText;
  final Color background;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontSize: fontSize,
              color: CreateDiaryScreenFunctions()
                      .isColorBright(background)
                  ? AppDarkColor.instance.secondaryText
                  : AppLightColor.instance.secondaryText,
            ),
        border: InputBorder.none,
      ),
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontSize:fontSize ,
            color:
                CreateDiaryScreenFunctions().isColorBright(background)
                    ? Colors.black
                    : Colors.white,
          ),
      textCapitalization: TextCapitalization.sentences,
      autofocus: true,
      maxLines: null,
    );
  }
}
