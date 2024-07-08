import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../profile/view/page/account_page.dart';
import '../../diary/view/page/calendar_page/calendar_page.dart';
import '../../diary/view/page/gallery_page/gallery_page.dart';
import '../../home/home_page.dart';
import '../bloc/main_navigation_bloc/main_navigation_bloc.dart';
import '../widget/app_bottom_bar.dart';

class MainNavigationMenu extends StatefulWidget {
  const MainNavigationMenu({super.key});

  @override
  State<MainNavigationMenu> createState() => _MainNavigationMenuState();
}

class _MainNavigationMenuState extends State<MainNavigationMenu> {
  final List<Widget> _pageList = [
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

  late PageController pageController;
  final MainNavigationBloc _mainNavigationBloc = MainNavigationBloc();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    _mainNavigationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (int index) =>
            _mainNavigationBloc.add(MainNavigationEvent(index)),
        controller: pageController,
        children: _pageList,
      ),
      bottomNavigationBar: AppBottomBar(
        pageController: pageController,
        mainNavigationBloc: _mainNavigationBloc,
        titleList: titleList,
        boldIcons: boldIcons,
        lightIcons: lightIcons,
      ),
    );
  }
}
