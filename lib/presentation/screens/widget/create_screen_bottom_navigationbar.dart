import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CreatePageBottomNav extends StatelessWidget {
  final ValueNotifier<int> selectedIndexNotifier;
  final Function(int) onTap;

  const CreatePageBottomNav({
    Key? key,
    required this.selectedIndexNotifier,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BottomNavigationBar(
            selectedItemColor: const Color(0xFF835DF1),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: onTap,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Ionicons.time_outline),
                label: 'Time',
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.image_outline),
                label: 'Gallery',
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.color_palette_outline),
                label: 'Color',
              ),
            ],
          ),
        );
      },
    );
  }
}
