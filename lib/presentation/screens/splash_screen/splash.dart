import 'dart:async';
import 'package:diary/application/controllers/hive_app_preference_db_ops.dart';
import 'package:diary/core/models/app_preference_db_model.dart';
import 'package:diary/presentation/screens/login_signin_screen/welcome_screen.dart';
import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:diary/presentation/screens/splash_screen/onboarding.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key});

  @override
  Widget build(BuildContext context) {
    final appPreferenceFunctions = AppPreferenceFunctions();

    Timer(const Duration(seconds: 1), () async {
      
      final onboardingStatus =
          await appPreferenceFunctions.getOnboardingStatus();

      if (onboardingStatus == null || onboardingStatus.showOnboarding == true) {
        final updatedOnboardingStatus =
            AppPreference(id: '1', showOnboarding: false);
        await appPreferenceFunctions.showOnboarding(updatedOnboardingStatus);
        Navigator.pushReplacementNamed(context, '/onboarding');
      } else {
       
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainScreen(),
          ),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Image(
          image: Theme.of(context).brightness == Brightness.light
              ? const AssetImage(
                  'assets/images/forever_memories_logo/forever_memories_logo_black.png',
                )
              : const AssetImage(
                  'assets/images/forever_memories_logo/forever_memories_logo_white.png',
                ),
        ),
      ),
    );
  }
}
