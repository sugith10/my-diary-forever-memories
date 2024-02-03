import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:diary/controller/db_controller/app_preference_db_ops_hive.dart';
import 'package:diary/model/app_preference_db_model.dart';
import 'package:diary/model/content_model.dart';
import 'package:diary/provider/onboarding_scrn_prvdr.dart';
import 'package:diary/view/screens/main_screen/main_screen.dart';
import 'package:diary/view/screens/splash_screen/widget/onboarding_dot.dart';
import 'package:diary/view/util/get_colors.dart';
import 'package:diary/view/util/onboarding_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class Onboarding extends StatelessWidget {
  Onboarding({super.key, required this.onboardingState});

  final PageController pageController = PageController(initialPage: 0);
  final OnboardingScreenProvider onboardingState;

  Map<double, double> titleFontSizes = {
    700: 10.0,
    750: 12.0,
    780: 18.0,
    800: 20.0,
    820: 24.0,
    850: 30.0,
    900: 32.0,
  };

  Map<double, double> descriptionFontSizes = {
    700: 12.0,
    750: 13.0,
    780: 14.0,
    800: 15.0,
    820: 18.0,
    850: 20.0,
    900: 22.0,
  };

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = GetColors().getThemeMode(context);
    double screenHeight = MediaQuery.of(context).size.height;
     double screenWidth = MediaQuery.of(context).size.width ;

    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Column(
          children: [
            SizedBox(height:calculateLottieSizedbox(screenHeight, screenWidth)), 
            Lottie.asset(
              OnboardingScreenFunctions().getLottieJsonFileName(themeMode),
              width: double.infinity,
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: OnboardingContentList().contents.length,
                onPageChanged: (int index) {
                  onboardingState.updateIndex(index);
                },
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      
                      const Spacer(),
                      Text(
                        OnboardingContentList().contents[i].title,
                        style: TextStyle(
                           fontSize:calculateTitleFontSize( screenHeight, screenWidth).sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          OnboardingContentList().contents[i].discription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize:calculateDescriptionFontSize( screenHeight, screenWidth), 
                            color: OnboardingScreenFunctions()
                                .getDescriptionColor(context),
                          ),
                        ),
                      ),
                       const Spacer(),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                OnboardingContentList().contents.length,
                (index) => BuidDot(
                    index: index,
                    context: context,
                    onboardingState: onboardingState),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (onboardingState.currentIndex ==
                      OnboardingContentList().contents.length - 1) {
                    AppPreferenceCtrl()
                        .showOnboarding(AppPreference(showOnboarding: false));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainScreen(),
                      ),
                    );
                  } else {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.bounceIn,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                  backgroundColor: const Color(0xFF835DF1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: FadeInUp(
                  delay: const Duration(milliseconds: 600),
                  duration: const Duration(milliseconds: 700),
                  child: Text(
                    onboardingState.currentIndex ==
                            OnboardingContentList().contents.length - 1
                        ? "Continue"
                        : "Next",
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                AppPreferenceCtrl()
                    .showOnboarding(AppPreference(showOnboarding: false));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainScreen(),
                  ),
                );
              },
              child: FadeInUp(
                delay: const Duration(milliseconds: 1000),
                duration: const Duration(milliseconds: 1000),
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Color.fromARGB(255, 150, 169, 194)),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }




double calculateTitleFontSize(double screenHeight, double screenWidth) {
  double fontSize;
log('$screenHeight');
log('$screenWidth');
  if (screenHeight >= 700 && screenHeight < 750 && screenWidth >= 320 && screenWidth < 400) {
    log('a');
    fontSize = 15.0;
  } else if (screenHeight >= 750 && screenHeight < 780 && screenWidth >= 360 && screenWidth < 411) {
    log('b');
    fontSize = 16.0;
  } else if (screenHeight >= 780 && screenHeight < 800 && screenWidth >= 375 && screenWidth < 411) {
    log('c');
    fontSize = 17.0;
  } else if (screenHeight >= 800 && screenHeight < 820 && screenWidth >= 375 && screenWidth < 411) {
    log('d');
    fontSize = 18.0;
  } else if (screenHeight >= 820 && screenHeight < 850 && screenWidth >= 390 && screenWidth < 411) {
    log('e');
    fontSize = 19.0;
  } else if (screenHeight >= 850 && screenHeight < 900 && screenWidth >= 411 && screenWidth < 480) {
    log('f');
    fontSize = 20.0;
  } else if (screenHeight >= 850 && screenWidth >= 390) {
    log('g');
    fontSize = 22.0;
  } else {
    log('h');
    fontSize = 22.0; 
  }

  fontSize  * 0.01;

  return fontSize;
}

double calculateDescriptionFontSize(double screenHeight, double screenWidth) {
  double fontSize;

  if (screenHeight >= 700 && screenHeight < 750 && screenWidth >= 320 && screenWidth < 400) {
    log('a');
    fontSize = 15.0;
  } else if (screenHeight >= 750 && screenHeight < 780 && screenWidth >= 320 && screenWidth < 410) {
    log('b');
    fontSize = 16.0;
  } else if (screenHeight >= 780 && screenHeight < 800 && screenWidth >= 400 && screenWidth < 450) {
    log('c');
    fontSize = 17.0;
  } else if (screenHeight >= 800 && screenHeight < 820 && screenWidth >= 400 && screenWidth < 480) {
    log('d');
    fontSize = 17.5;
  } else if (screenHeight >= 820 && screenHeight < 850 && screenWidth >= 410 && screenWidth < 480) {
    log('e');
    fontSize = 18.0;
  } else if (screenHeight >= 850 && screenHeight < 900 && screenWidth >= 410 && screenWidth < 480) {
    log('f');
    fontSize = 18.0;
  } else if (screenHeight >= 900 && screenWidth >= 390) {
    log('g');
    fontSize = 22.0;
  } else {
    log('h');
    fontSize = 21.0; 
  }

  fontSize  * 0.01;

  return fontSize;
}

double calculateLottieSizedbox(double screenHeight, double screenWidth) {
  double sizedBox;

  if (screenHeight >= 700 && screenHeight < 750 && screenWidth >= 320 && screenWidth < 400) {
    log('a');
    sizedBox = 0;
  } else if (screenHeight >= 750 && screenHeight < 780 && screenWidth >= 320 && screenWidth < 410) {
    log('b');
    sizedBox = 10;
  } else if (screenHeight >= 780 && screenHeight < 800 && screenWidth >= 390 && screenWidth < 450) {
    log('c');
    sizedBox = 20;
  } else if (screenHeight >= 800 && screenHeight < 820 && screenWidth >= 400 && screenWidth < 480) {
    log('d');
    sizedBox = 35;
  } else if (screenHeight >= 820 && screenHeight < 850 && screenWidth >= 410 && screenWidth < 480) {
    log('e');
    sizedBox = 40;
  } else if (screenHeight >= 850 && screenHeight < 900 && screenWidth >= 410 && screenWidth < 480) {
    log('f');
    sizedBox = 50;
  } else if (screenHeight >= 850 && screenWidth >= 390) {
    log('gfds');
    sizedBox = 65;
  } else {
    log('hsds');
    sizedBox = 65; 
  }

  sizedBox  * 0.01;

  return sizedBox;
}

}
