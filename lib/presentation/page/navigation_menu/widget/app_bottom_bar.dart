import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/controller/screen_controller/screen_size_find_controller/main_screen_size_controller/main_screen_size_controller.dart';
import '../../../providers/main_scrn_prvdr.dart';
import '../../../util/get_theme_type.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    super.key,
    required this.screenWidth,
    required this.currentIndex,
    required this.bottomNavigationProvider,
    required this.titleList,
    required this.screenHeight,
    required this.boldIcons,
    required this.lightIcons,
  });

  final double screenWidth;
  final int currentIndex;
  final MainScreenProvider bottomNavigationProvider;
  final List<String> titleList;
  final double screenHeight;
  final List<IconData> boldIcons;
  final List<IconData> lightIcons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: screenWidth * 0.155,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            final isSelected = index == currentIndex;
            return GestureDetector(
              onTap: () {
                bottomNavigationProvider.setCurrentIndex(index);
                HapticFeedback.lightImpact();
              },
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: isSelected ? screenWidth * 0.32 : screenWidth * 0.18,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: isSelected ? screenWidth * 0.13 : 0,
                            ),
                            AnimatedOpacity(
                              opacity: isSelected ? 1 : 0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: Text(
                                isSelected ? titleList[index] : '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MainScreenSizeCntrl()
                                      .calculateBottomNavFontSize(
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                      )
                                      .sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: isSelected ? screenWidth * 0.035 : 10,
                            ),
                            Icon(
                              isSelected ? boldIcons[index] : lightIcons[index],
                              size: screenWidth * 0.076,
                              color: isSelected
                                  ? isDark(context)
                                      ? const Color.fromARGB(221, 255, 255, 255)
                                      : const Color.fromARGB(221, 0, 0, 0)
                                  : isDark(context)
                                      ? const Color.fromARGB(66, 255, 255, 255)
                                      : const Color.fromARGB(66, 0, 0, 0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
