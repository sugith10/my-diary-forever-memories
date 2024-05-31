import 'package:diary/presentation/providers/onboarding_scrn_prvdr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BuidDot extends StatelessWidget {
  final int index;
  final OnboardingScreenProvider onboardingState;
  final BuildContext context;

  const BuidDot({ required this.index, required this.onboardingState, required  this.context, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.sh,
      width: onboardingState.currentIndex == index ? 25.sh : 10.sh,
      margin: EdgeInsets.only(right: 5.sh),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sh),
        color: const Color.fromRGBO(226, 232, 240, 1),
      ),
    );
  }
}


