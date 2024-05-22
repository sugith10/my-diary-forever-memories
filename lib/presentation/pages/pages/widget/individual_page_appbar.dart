import 'package:diary/presentation/pages/pages/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/pages/pages/widget/back_button.dart';
import 'package:flutter/material.dart';

import '../../../utils/assets/app_svg.dart';
import '../../../widgets/svg_icon.dart';

class IndividualPageAppBar extends StatelessWidget {
  final Function function;
  const IndividualPageAppBar({required this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      elevation: 0,
      bottom: const BottomBorderWidget(),
      leading: const BackButtonWidget(),
      actions: [
        IconButton(
              onPressed: () {
                function();
              },
              icon: const SvgIcon(path: AppSvg.more),
            )
      ],

    );
  }
}