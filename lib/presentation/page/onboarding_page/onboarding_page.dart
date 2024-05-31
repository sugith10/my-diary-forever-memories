import 'package:animate_do/animate_do.dart';
import 'package:diary/data/controller/database_controller/app_pref_db_controller.dart';
import 'package:diary/data/controller/screen_controller/screen_size_find_controller/onboarding_screen_size_cntrl/onboarding_screen_size_cntrl.dart';
import 'package:diary/data/model/hive/hive_db_model/app_preference_db_model/app_preference_db_model.dart';
import 'package:diary/presentation/util/content_model.dart';
import 'package:diary/presentation/util/get_theme_type.dart';
import 'package:diary/presentation/providers/onboarding_scrn_prvdr.dart';
import 'package:diary/presentation/navigation/screen_transitions/no_movement.dart';
import 'package:diary/presentation/util/onboarding_screen_functions.dart';
import 'package:diary/utils/assets/app_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


import '../navigation_menu/main_page.dart';
import 'widget/onboarding_dot.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController pageController = PageController(initialPage: 0);
  final OnboardingContentList onboardingContentList = OnboardingContentList();
  final OnboardingPageSizeCntrl _onboardingPageSizeCntrl =
      OnboardingPageSizeCntrl();
  final AppPrefDatabaseManager _appPreferenceCtrl = AppPrefDatabaseManager();

  @override
  Widget build(BuildContext context) {
    OnboardingScreenProvider onboardingState =
        Provider.of<OnboardingScreenProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Column(
          children: [
            SizedBox(
              height: OnboardingPageSizeCntrl().calculateLottieSizedbox(
                  screenHeight: screenHeight, screenWidth: screenWidth),
            ),
            Lottie.asset(
              isDark(context)
                  ? AppLottie.onboardingLight
                  : AppLottie.onboardingDark,
              width: double.infinity,
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingContentList.contents.length,
                onPageChanged: (int index) {
                  onboardingState.updateIndex(index);
                },
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      const Spacer(),
                      Text(
                        onboardingContentList.contents[index].title,
                        style: TextStyle(
                          fontSize: _onboardingPageSizeCntrl
                              .calculateTitleFontSize(
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                              )
                              .sh,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          onboardingContentList.contents[index].discription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: _onboardingPageSizeCntrl
                                .calculateDescriptionFontSize(
                                    screenHeight: screenHeight,
                                    screenWidth: screenWidth),
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
                onboardingContentList.contents.length,
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
                      onboardingContentList.contents.length - 1) {
                    _appPreferenceCtrl
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
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                child: FadeInUp(
                  delay: const Duration(milliseconds: 600),
                  duration: const Duration(milliseconds: 700),
                  child: Text(
                    onboardingState.currentIndex ==
                            onboardingContentList.contents.length - 1
                        ? "Continue"
                        : "Next",
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _appPreferenceCtrl
                    .showOnboarding(AppPreference(showOnboarding: false));

                Navigator.of(context).pushReplacement(noMovement(MainScreen()));
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
}
