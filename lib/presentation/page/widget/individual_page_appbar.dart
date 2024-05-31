import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'appbar_bottom_common.dart';

class IndividualPageAppBar extends StatelessWidget {
  final Function function;
  const IndividualPageAppBar({required this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      bottom: const BottomBorderWidget(),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          IconlyLight.arrow_left_2,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            function();
          },
          icon: const Icon(IconlyLight.setting),
        ),
      ],
    );
  }
}
