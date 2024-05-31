import 'package:diary/presentation/theme/app_color.dart';
import 'package:diary/utils/assets/app_svg.dart';
import 'package:diary/presentation/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class CreatePageBottomNav extends StatelessWidget {
  final ValueNotifier<int> selectedIndexNotifier;
  final Function(int) onTap;

  const CreatePageBottomNav({
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
            //TODO:change color here
            selectedItemColor: AppColor.primary.color,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: onTap,
            items: const [
              BottomNavigationBarItem(
                icon: SvgIcon(path: AppSvg.time),
                label: 'Time',
              ),
              BottomNavigationBarItem(
                icon: SvgIcon(path: AppSvg.gallery),
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
