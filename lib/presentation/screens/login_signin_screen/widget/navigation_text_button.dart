import 'package:flutter/material.dart';

class NavigationTextButtonRow extends StatelessWidget {
  final String leadingText;
  final String buttonText;
  final VoidCallback onPressed;

  const NavigationTextButtonRow({
    Key? key,
    required this.leadingText,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          leadingText,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Color(0xFF835DF1),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
