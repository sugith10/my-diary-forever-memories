import 'package:diary/providers/provider_mainscreen.dart';
import 'package:diary/screens/my_diary_screen/mydiary_screen.dart';
import 'package:diary/screens/calendar_screen/calendar_screen.dart';
import 'package:diary/screens/gallery_screen/gallery_screen.dart';
import 'package:diary/screens/profile_screen/account_screen.dart';
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
    'My Diary',
    'Calendar',
    'Gallery',
    'Account',
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<MainScreenProvider>(context).currentIndex;
    final bottomNavigationProvider = Provider.of<MainScreenProvider>(context);
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: WillPopScope(
         onWillPop: () async {
          return false;
        },
        child: _mainScreens[currentIndex],
      ),
      bottomNavigationBar: Container(
        height: displayWidth * 0.155,
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF835DF1).withOpacity(0.1),
              blurRadius: 38,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
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
                    width:
                        isSelected ? displayWidth * 0.32 : displayWidth * 0.18,
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: isSelected ? displayWidth * 0.12 : 0,
                      width: isSelected ? displayWidth * 0.32 : 0,
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
                    width:
                        isSelected ? displayWidth * 0.31 : displayWidth * 0.18,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: isSelected ? displayWidth * 0.13 : 0,
                            ),
                            AnimatedOpacity(
                              opacity: isSelected ? 1 : 0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: Text(
                                isSelected ? listOfStrings[index] : '',
                                style:  TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                   fontFamily: 'Poppins',
                                  fontSize: 10.sp,
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
                              width: isSelected ? displayWidth * 0.03 : 20,
                            ),
                            Icon(
                              listOfIcons[index],
                              size: displayWidth * 0.076,
                              color:
                                  isSelected ? Colors.black87 : Colors.black26,
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
