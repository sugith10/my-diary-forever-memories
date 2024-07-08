import 'package:diary/view_model/providers/theme_select_prvdr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../view_model/providers/main_scrn_prvdr.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    super.key,
    required this.currentIndex,
    required this.bottomNavigationProvider,
    required this.titleList,
    required this.boldIcons,
    required this.lightIcons,
  });

  final int currentIndex;
  final MainScreenProvider bottomNavigationProvider;
  final List<String> titleList;
  final List<IconData> boldIcons;
  final List<IconData> lightIcons;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SalomonBottomBar(
      currentIndex: currentIndex,
      onTap: (i) {
        bottomNavigationProvider.setCurrentIndex(i);
        HapticFeedback.lightImpact();
      },
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: Icon(
            bottomNavigationProvider.currentIndex == 0
                ? boldIcons[0]
                : lightIcons[0],
          ),
          title: Text(titleList[currentIndex]),
          selectedColor: themeProvider.pageOne,
        ),

        /// Calendar
        SalomonBottomBarItem(
          icon: Icon(bottomNavigationProvider.currentIndex == 1
              ? boldIcons[1]
              : lightIcons[1]),
          title: Text(titleList[currentIndex]),
          selectedColor: themeProvider.pageTwo,
        ),

        /// Gallery
        SalomonBottomBarItem(
          icon: Icon(bottomNavigationProvider.currentIndex == 2
              ? boldIcons[2]
              : lightIcons[2]),
          title: Text(titleList[currentIndex]),
          selectedColor: themeProvider.pageThree,
        ),

        /// Profile
        SalomonBottomBarItem(
          icon: Icon(bottomNavigationProvider.currentIndex == 3
              ? boldIcons[3]
              : lightIcons[3]),
          title: Text(titleList[currentIndex]),
          selectedColor: themeProvider.pageFour,
        ),
      ],
    );
  }
}
