import 'dart:developer';

import 'package:diary/provider/main_scrn_prvdr.dart';
import 'package:diary/view/screens/my_diary_screen/mydiary_screen.dart';
import 'package:diary/view/screens/calendar_screen/calendar_screen.dart';
import 'package:diary/view/screens/gallery_screen/gallery_screen.dart';
import 'package:diary/view/screens/account_screen/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _mainScreens = [
    const MyDiaryScreen(),
    CalendarScreen(),
    const GalleryScreen(),
    const AccountScreen(),
  ];

  final List<IconData> listOfIcons = [
    Icons.menu_book_rounded,
    Icons.calendar_month_outlined,
    Ionicons.images_outline,
    Icons.person_outline_sharp,
  ];

  final List<String> listOfStrings = [
    'My Diary ',
    'Calendar ',
    'Gallery ',
    'Account ',
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<MainScreenProvider>(context).currentIndex;
    final bottomNavigationProvider = Provider.of<MainScreenProvider>(context);

         double screenWidth = MediaQuery.of(context).size.width ;
        double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: PopScope(
        child: _mainScreens[currentIndex],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0, top: 0, right: 6, left: 6),
        child: SizedBox(
          height: screenWidth * 0.155,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) {
              final isSelected = index == currentIndex;
              return InkWell(
                onTap: () {
                  bottomNavigationProvider.setCurrentIndex(index);
                  HapticFeedback.lightImpact();
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: isSelected
                          ? screenWidth * 0.32
                          : screenWidth * 0.18,
                      alignment: Alignment.center,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: isSelected ? screenWidth * 0.12 : 0,
                        width: isSelected ? screenWidth * 0.32 : 0,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF5B6ABF).withOpacity(0.3)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: isSelected
                          ? screenWidth * 0.31
                          : screenWidth * 0.18,
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
                                  isSelected ? listOfStrings[index] : '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                         calculateBottomNavFontSize(screenHeight,screenWidth).sp,
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
                                width: isSelected ? screenWidth * 0.03 : 20,
                              ),
                              Icon(
                                listOfIcons[index],
                                size: screenWidth * 0.076,
                                color: isSelected
                                    ? Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black87
                                        : Colors.white
                                    : Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black26
                                        : Colors.white54,
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
      ),
    );
  }


  double calculateBottomNavFontSize(double screenHeight, double screenWidth) {
  double fontSize;
  log('$screenHeight & $screenWidth' );
  if (screenHeight >= 700 && screenHeight < 750 && screenWidth >= 320 && screenWidth < 360) {
    log('a');
    fontSize = 8.5;
  } else if (screenHeight >= 700 && screenHeight < 780 && screenWidth >= 300 && screenWidth < 400) {
    log('b');
    fontSize = 8.5;
  } else if (screenHeight >= 780 && screenHeight < 800 && screenWidth >= 375 && screenWidth < 411) {
    log('c');
    fontSize = 8.7;
  } else if (screenHeight >= 800 && screenHeight < 820 && screenWidth >= 375 && screenWidth < 411) {
    log('d');
    fontSize = 8.8;
  } else if (screenHeight >= 820 && screenHeight < 850 && screenWidth >= 411 && screenWidth < 440) {
    log('e');
    fontSize = 8.9;
  } else if (screenHeight >= 850 && screenHeight < 900 && screenWidth >= 411 && screenWidth < 480) {
    log('f');
    fontSize = 9.5;
  } else if (screenHeight >= 900 && screenWidth >= 480) {
    log('g');
    fontSize = 10.0;
  } else {
    log('h');
    fontSize = 10.0; 
  }

  fontSize  * 0.01;

  return fontSize;
}
}
