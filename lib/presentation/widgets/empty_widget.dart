
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String image;
  final String message;
  const EmptyWidget({
    required this.message,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image),
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