import 'package:diary/core/theme/app_color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../bloc/main_navigation_bloc/main_navigation_bloc.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    super.key,
    required this.pageController,
    required this.mainNavigationBloc,
    required this.titleList,
    required this.boldIcons,
    required this.lightIcons,
  });

  final PageController pageController;
  final MainNavigationBloc mainNavigationBloc;
  final List<String> titleList;
  final List<IconData> boldIcons;
  final List<IconData> lightIcons;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigationBloc, MainNavigationState>(
      bloc: mainNavigationBloc,
      builder: (context, state) {
        if (state is MainNavigationIndexState) {
          return SalomonBottomBar(
            currentIndex: state.index,
            onTap: (i) {
              mainNavigationBloc.add(MainNavigationEvent(i));
              HapticFeedback.lightImpact();
              pageController.animateToPage(
                i,
                duration: const Duration(milliseconds: 100),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(
                  state.index == 0 ? boldIcons[0] : lightIcons[0],
                ),
                title: Text(titleList[state.index]),
                selectedColor: Theme.of(context).brightness == Brightness.light
                    ? AppLightColor.instance.pageOne
                    : AppDarkColor.instance.pageOne,
                unselectedColor:
                    Theme.of(context).brightness == Brightness.light
                        ? AppLightColor.instance.unfocus
                        : AppDarkColor.instance.unfocus,
              ),

              /// Calendar
              SalomonBottomBarItem(
                icon: Icon(state.index == 1 ? boldIcons[1] : lightIcons[1]),
                title: Text(titleList[state.index]),
                selectedColor: Theme.of(context).brightness == Brightness.light
                    ? AppLightColor.instance.pageTwo
                    : AppDarkColor.instance.pageTwo,
                unselectedColor:
                    Theme.of(context).brightness == Brightness.light
                        ? AppLightColor.instance.unfocus
                        : AppDarkColor.instance.unfocus,
              ),

              /// Gallery
              SalomonBottomBarItem(
                icon: Icon(state.index == 2 ? boldIcons[2] : lightIcons[2]),
                title: Text(titleList[state.index]),
                selectedColor: Theme.of(context).brightness == Brightness.light
                    ? AppLightColor.instance.pageThree
                    : AppDarkColor.instance.pageThree,
                unselectedColor:
                    Theme.of(context).brightness == Brightness.light
                        ? AppLightColor.instance.unfocus
                        : AppDarkColor.instance.unfocus,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(state.index == 3 ? boldIcons[3] : lightIcons[3]),
                title: Text(titleList[state.index]),
                selectedColor: Theme.of(context).brightness == Brightness.light
                    ? AppLightColor.instance.pageFour
                    : AppDarkColor.instance.pageFour,
                unselectedColor:
                    Theme.of(context).brightness == Brightness.light
                        ? AppLightColor.instance.unfocus
                        : AppDarkColor.instance.unfocus,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
