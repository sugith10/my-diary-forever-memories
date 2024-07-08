import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/widget/svg_icon.dart';
import '../../../../core/util/asset_path/app_svg.dart';

class CreatePageBottomBar extends StatelessWidget {
  final ValueNotifier<int> selectedIndexNotifier;
  final Function(int) onTap;

  const CreatePageBottomBar({
    super.key,
    required this.selectedIndexNotifier,
    required this.onTap,
  });

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
            enableFeedback: true,
            elevation: 1,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: onTap,
            items: const [
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.clock,
                ),
                label: 'Time',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.images,
                ),
                label: 'Gallery',
              ),
              BottomNavigationBarItem(
                icon: SvgIcon(path: AppSvg.colorPick),
                label: 'Color',
              ),
            ],
          ),
        );
      },
    );
  }
}
