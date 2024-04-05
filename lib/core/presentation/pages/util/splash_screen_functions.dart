// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:diary/controller/database_controller/app_pref_db_controller.dart';
import 'package:diary/core/presentation/utils/screen_transitions/no_movement.dart';
import 'package:diary/core/presentation/pages/pages/main_page/main_page.dart';
import 'package:diary/core/presentation/pages/pages/onboarding_page/onboarding_page.dart';
import 'package:flutter/material.dart';

class SplashScreenController {
  _setup(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {
      final onboardingStatus = await AppPrefDatabaseManager().getOnboardingStatus();

      if (onboardingStatus == null || onboardingStatus.showOnboarding == true) {
        Navigator.of(context).pushReplacement(noMovement(Onboarding()));
      } else {
        Navigator.of(context).pushReplacement(noMovement(MainScreen()));
      }
    });
  }

  setup(BuildContext context) {
    _setup(context);
  }
}
