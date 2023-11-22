import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final FocusNode focusNode;
  final bool isFocused;
  final TextEditingController controller;

  const InputField({
    super.key,
    required this.labelText,
    required this.focusNode,
    required this.isFocused,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 700),
      duration: const Duration(milliseconds: 800),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                labelText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.8.h),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: .3.h),
            decoration: BoxDecoration(
              color: isFocused ? Colors.white : const Color(0xFFF1F0F5),
              border: Border.all(width: 1, color: const Color(0xFFD2D2D4)),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                if (isFocused)
                  BoxShadow(
                    color: const Color(0xFF835DF1).withOpacity(.3),
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  ),
              ],
            ),
            child: TextField(
              style: const TextStyle(fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: labelText,
              ),
              focusNode: focusNode,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
