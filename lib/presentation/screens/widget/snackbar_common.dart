import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;

  const CustomSnackBar({
    required this.message,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(2.h),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

    return const SizedBox();
  }
}
