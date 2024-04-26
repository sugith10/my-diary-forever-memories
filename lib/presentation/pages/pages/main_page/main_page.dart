import 'package:diary/data/controller/screen_controller/screen_size_find_controller/main_screen_size_controller/main_screen_size_controller.dart';
import 'package:diary/presentation/providers/main_scrn_prvdr.dart';
import 'package:diary/presentation/pages/pages/my_diary_page/mydiary_page.dart';
import 'package:diary/presentation/pages/pages/calendar_page/calendar_page.dart';
import 'package:diary/presentation/pages/pages/gallery_page/gallery_page.dart';
import 'package:diary/presentation/pages/pages/account_page/account_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _mainScreens = [
    const HomePage(),
   const CalendarScreen(),
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
                               
                                    fontSize:
                                     MainScreenSizeCntrl().calculateBottomNavFontSize(screenHeight:  screenHeight,screenWidth:  screenWidth).sp,
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



}
