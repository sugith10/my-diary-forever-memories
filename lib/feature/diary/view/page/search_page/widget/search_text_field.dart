import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SearchTextField extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;
  const SearchTextField({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (query) {
        onChanged(query);
      },
      autofocus: true,
      decoration: InputDecoration(
        hintText: ' Search...',
        border: InputBorder.none,
        prefixIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            IconlyLight.arrow_left,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            controller.clear();
          },
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      style: const TextStyle(fontSize: 20),
      textCapitalization: TextCapitalization.sentences,
    );
  }
}
