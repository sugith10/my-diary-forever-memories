import 'package:animate_do/animate_do.dart';

import 'package:diary/models/content_model.dart';
import 'package:diary/screens/home/mainscreen.dart';
import 'package:diary/screens/screen0.1_auth/welcome_screen.dart';
import 'package:diary/screens/screen0_welcome/provider_onboarding.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Onbording extends StatelessWidget {
  Onbording({super.key, required this.onboardingState});

  final PageController pageController = PageController(initialPage: 0);
  final OnboardingState onboardingState;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
          Spacer(),
            Lottie.asset(
              'images/animation-1697987169484.json',
              width: double.infinity,
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  onboardingState.updateIndex(index);
                },
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      Text(
                        contents[i].title,
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 1.5.h),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          contents[i].discription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color.fromARGB(255, 68, 68, 68),
                          ),
                        ),
                      ),
                     
                    ],
                  );
                },
              ),
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                ),
              ),
            ),
            
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (onboardingState.currentIndex == contents.length - 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WelcomePage(),
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
                    fontSize: 18.sp,
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
                    onboardingState.currentIndex == contents.length - 1
                        ? "Continue"
                        : "Next",
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
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
                child: Text(
                  'Skip',
                  style: TextStyle(color: Color.fromARGB(255, 150, 169, 194)),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    const Color lightBlue = Color(0xFFE2E8F0);
    return Container(
      height: 10.sp,
      width: onboardingState.currentIndex == index ? 25.sp : 10.sp,
      margin: EdgeInsets.only(right: 5.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: lightBlue,
      ),
    );
  }
}
