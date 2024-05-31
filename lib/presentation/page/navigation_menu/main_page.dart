import 'package:diary/presentation/providers/main_scrn_prvdr.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../account_page/account_page.dart';
import '../calendar_page/calendar_page.dart';
import '../gallery_page/gallery_page.dart';
import '../home_page/home_page.dart';
import 'widget/app_bottom_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> _mainScreens = [
    const HomePage(),
    const CalendarScreen(),
    const GalleryScreen(),
    const AccountScreen(),
  ];

  final List<IconData> lightIcons = [
    IconlyLight.home,
    IconlyLight.calendar,
    IconlyLight.image,
    IconlyLight.profile,
  ];

  final List<IconData> boldIcons = [
    IconlyBold.home,
    IconlyBold.calendar,
    IconlyBold.image,
    IconlyBold.profile,
  ];

  final List<String> titleList = [
    'Home',
    'Calendar ',
    'Gallery ',
    'Account ',
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<MainScreenProvider>(context).currentIndex;
    final bottomNavigationProvider = Provider.of<MainScreenProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: PopScope(
        child: _mainScreens[currentIndex],
      ),
      bottomNavigationBar: AppBottomBar(
        screenWidth: screenWidth,
        currentIndex: currentIndex,
        bottomNavigationProvider: bottomNavigationProvider,
        titleList: titleList,
        screenHeight: screenHeight,
        boldIcons: boldIcons,
        lightIcons: lightIcons,
      ),
    );
  }
}
