import 'package:diary/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class NavigationElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const NavigationElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

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
        backgroundColor: AppColor.primary.color ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: FadeInUp(
        delay: const Duration(milliseconds: 700),
        duration: const Duration(milliseconds: 800),
        child: Text(buttonText, style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
