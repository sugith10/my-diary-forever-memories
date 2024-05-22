import 'package:flutter/material.dart';

class OnboardingScreenFunctions{
 

   Color _getDescriptionColor(BuildContext context){
    return Theme.of(context).brightness == Brightness.light ? const Color.fromARGB(255, 68, 68, 68) : const Color.fromARGB(255, 190, 190, 190);

   }

   Color getDescriptionColor(BuildContext context) {
    return _getDescriptionColor(context);
  }

 
}