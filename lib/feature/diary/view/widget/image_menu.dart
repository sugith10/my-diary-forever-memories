import 'package:flutter/material.dart';

class ImageMenu {
  ImageMenu._();

  static void showImageMenu({
    required BuildContext context,
    required TapDownDetails details,
    required VoidCallback openImageCall,
    required VoidCallback changeImageCall,
    required VoidCallback removeImageCall,
  }) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem(
          onTap: () => openImageCall(),
          child: const Center(
            child: Text(
              'Open',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            changeImageCall();
          },
          child: const Center(
            child: Text(
              'Change',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            removeImageCall();
          },
          child: const Center(
            child: Text(
              'Remove',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
