

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:diary/data/controller/database_controller/app_pref_db_controller.dart';
import 'package:diary/view/route/page_transition/no_movement.dart';
import 'package:flutter/material.dart';

import '../page/navigation_menu/main_page.dart';
import '../page/onboarding_page/onboarding_page.dart';

class SplashScreenController {
_setup(BuildContext context) {
  Timer? timer;

  timer = Timer(
    const Duration(seconds: 2),
    () async {
      final onboardingStatus =
          await AppPrefDatabaseManager().getOnboardingStatus();

      if (onboardingStatus == null ||
          onboardingStatus.showOnboarding == true) {
        Navigator.of(context).pushReplacement(noMovement(const Onboarding()));
      } else {
        Navigator.of(context).pushReplacement(noMovement(MainScreen()));
      }

      // Dispose the timer after completing its task
      timer?.cancel();
    },
  );
}


  setup(BuildContext context) {
    _setup(context);
  }
}
