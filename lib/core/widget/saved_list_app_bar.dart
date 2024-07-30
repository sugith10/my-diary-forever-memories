import 'package:flutter/material.dart';

import '../theme/app_properties/app_icons.dart';

class SavedListModelAppBar extends StatelessWidget implements PreferredSizeWidget {
final String title;
final IconData icon;
final VoidCallback callback;

  const SavedListModelAppBar({
    super.key,
    required this.title,
    required this.icon,
    required this.callback,
    
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon:AppIcon.back,
      ),
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
         callback();
          },
          icon:  Icon(
          icon,
            size: 25,
          ),
        )
      ],
    );
  }
  
   @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
