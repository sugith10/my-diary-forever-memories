import 'package:diary/color/primary_colors.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function() onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: TextButton(
        onPressed: onPressed,
        child:  Text(
          'Save',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
          ? AppColor.black.color
          : Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
