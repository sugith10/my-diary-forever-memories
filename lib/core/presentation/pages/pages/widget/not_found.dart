import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  final String message;
  const NotFound({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Oops...',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
         message ,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
