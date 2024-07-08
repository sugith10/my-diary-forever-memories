
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SkipWidget extends StatelessWidget {
  final VoidCallback callback;
  const SkipWidget({
    required this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        callback();
      },
      child: FadeInUp(
        delay: const Duration(milliseconds: 1000),
        duration: const Duration(milliseconds: 1000),
        child: const Text(
          'Skip',
          style: TextStyle(color: Color.fromARGB(255, 150, 169, 194)),
        ),
      ),
    );
  }
}
