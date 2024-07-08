import 'package:flutter/material.dart';

class ThemeCardBody extends StatelessWidget {
  final String text;
  final Color color;

  const ThemeCardBody({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3)
                          : const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 4))
                ]),
            height: 60,
            width: 210,
          ),
        ),
      ],
    );
  }
}
