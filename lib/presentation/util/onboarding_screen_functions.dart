import 'package:flutter/material.dart';

class OnboardingScreenFunctions{
   String _getLottieJsonFileName(ThemeMode themeMode) {
    return themeMode == ThemeMode.dark
        ? 'assets/images/onboarding_screen_animation/onboarding_lottie_dark.json'
        : 'assets/images/onboarding_screen_animation/onboarding_lottie_light.json';
  }

  String getLottieJsonFileName(ThemeMode themeMode){
    return _getLottieJsonFileName(themeMode);
  }

   Color _getDescriptionColor(BuildContext context){
    return Theme.of(context).brightness == Brightness.light ? const Color.fromARGB(255, 68, 68, 68) : Color.fromARGB(255, 190, 190, 190);

   }

   Color getDescriptionColor(BuildContext context) {
    return _getDescriptionColor(context);
  }

 
}