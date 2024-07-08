import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? children;
  const CustomAppBar({
    this.title,
    this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: title == null ? IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          IconlyLight.arrow_left_2,
        )
      ) : null,
      title: title,
      actions: children,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
