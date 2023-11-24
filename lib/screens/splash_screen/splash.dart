import 'dart:async';
import 'package:diary/screens/auth_screen/welcome_screen.dart';
import 'package:diary/screens/splash_screen/onboarding.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WelcomePage()));
    });

    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Image(image: AssetImage('images/first-img.png'))));
  }
}
