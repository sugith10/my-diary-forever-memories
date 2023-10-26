import 'package:diary/screens/custombottomnavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:diary/screens/account_screen.dart';
import 'package:diary/screens/calendar_screen.dart';
import 'package:diary/screens/mydiary_screen.dart';
import 'package:diary/screens/gallery_screen.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _mainScreens[_currentIndex],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
