import 'package:diary/core/theme/app_properties/app_icons.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? children;
  final bool showLeading;
  const DefaultAppBar({
    this.title,
    this.children,
    this.showLeading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: title == null
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: AppIcon.back,
            )
          : showLeading
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: AppIcon.back,
                )
              : null,
      title: title,
      actions: children,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
