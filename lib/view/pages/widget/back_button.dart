import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
        //This statement hides the keyboard when the back button is pressed, contributing to a smoother user experience.
        FocusScope.of(context).requestFocus(FocusNode());
      },
      icon: const Icon(
        Ionicons.chevron_back_outline,
        size: 25,
      ),
    );
  }
}
