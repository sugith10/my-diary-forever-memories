// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:diary/controller/db_controller/app_preference_db_ops_hive.dart';
import 'package:diary/view/screen_transitions/no_movement.dart';
import 'package:diary/view/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenController {
  _setup(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {
      final onboardingStatus = await AppPreferenceCtrl().getOnboardingStatus();
      // WidgetsBinding.instance.addPostFrameCallback((_) {
        if (onboardingStatus == null || onboardingStatus.showOnboarding == true) {
        
          Navigator.pushReplacementNamed(context, '/onboarding');
        } else {
        
          Navigator.of(context).pushReplacement(noMovement(MainScreen()));
        }
      // }
      // );
    });
  }
  setup(BuildContext context){
    _setup(context);
  }
}
