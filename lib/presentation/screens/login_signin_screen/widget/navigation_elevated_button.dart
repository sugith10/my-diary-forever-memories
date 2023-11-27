import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class NavigationElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const NavigationElevatedButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'Satoshi',
        ),
        backgroundColor: const Color(0xFF835DF1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: FadeInUp(
        delay: const Duration(milliseconds: 700),
        duration: const Duration(milliseconds: 800),
        child: Text(buttonText),
      ),
    );
  }
}
