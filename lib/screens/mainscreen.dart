import 'package:diary/screens/account_screen.dart';
import 'package:diary/screens/calendar_screen.dart';
import 'package:diary/screens/mydiary_screen.dart';
import 'package:diary/screens/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 
  int _currentIndex = 0;

  final List<Widget> _mainScreens = [
    MyDiaryScreen(),
    CalendarScreen(),
    GalleryScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
         
        body: _mainScreens[_currentIndex],
        bottomNavigationBar: Container(
                      margin: EdgeInsets.all(displayWidth * .05),
                      height: displayWidth * .155,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 30,
                            offset: Offset(0, 10),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                            horizontal: displayWidth * .02),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            setState(() {
                              _currentIndex = index;
                              HapticFeedback.lightImpact();
                            });
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Stack(
                            children: [
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == _currentIndex
                                    ? displayWidth * .32
                                    : displayWidth * .18,
                                alignment: Alignment.center,
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  height: index == _currentIndex
                                      ? displayWidth * .12
                                      : 0,
                                  width: index == _mainScreens
                                      ? displayWidth * .32
                                      : 0,
                                  decoration: BoxDecoration(
                                    color: index == _currentIndex
                                        ? Colors.blueAccent.withOpacity(.2)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == _currentIndex
                                    ? displayWidth * .31
                                    : displayWidth * .18,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        AnimatedContainer(
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          width: index == _currentIndex
                                              ? displayWidth * .13
                                              : 0,
                                        ),
                                        AnimatedOpacity(
                                          opacity:
                                              index == _currentIndex ? 1 : 0,
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          child: Text(
                                            index == _currentIndex
                                                ? '${listOfStrings[index]}'
                                                : '',
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        AnimatedContainer(
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          width: index == _currentIndex
                                              ? displayWidth * .03
                                              : 20,
                                        ),
                                        Icon(
                                          listOfIcons[index],
                                          size: displayWidth * .076,
                                          color: index == _currentIndex
                                              ? Colors.blueAccent
                                              : Colors.black26,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
      ),
    );

     
  }

  List<IconData> listOfIcons = [
    Icons.menu_book_rounded,
    Icons.calendar_month_outlined,
    Icons.photo_camera_back_outlined,
    Icons.person_outline_sharp,
  ];

  List<String> listOfStrings = [
    'My Diary',
    'Calendar',
    'Gallery',
    'Account',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


