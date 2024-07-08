import 'package:flutter/material.dart';

class ContentDivider extends StatelessWidget {
  const ContentDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const SizedBox(height: 10,),
        Divider(
                        color:  Theme.of(context).brightness == Brightness.light
              ? const Color.fromARGB(251, 237, 237, 237) : const Color.fromARGB(250, 20, 20, 20)
              ),
              const SizedBox(height: 10,)
      ],
    );
  }
}