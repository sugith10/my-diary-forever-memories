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
        child: const Text(
          'Save',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
