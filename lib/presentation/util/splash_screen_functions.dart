import 'dart:async';

import 'package:diary/controllers/app_preference_db_ops_hive.dart';
import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenFunc {
  _setup(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {
      final onboardingStatus = await AppPreferenceCtrl().getOnboardingStatus();
      // WidgetsBinding.instance.addPostFrameCallback((_) {
        if (onboardingStatus == null || onboardingStatus.showOnboarding == true) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/onboarding');
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => MainScreen(),
            ),
          );
        }
      // }
      // );
    });
  }
  setup(BuildContext context){
    _setup(context);
  }
}
