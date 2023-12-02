import 'dart:async';
import 'package:diary/presentation/screens/login_signin_screen/welcome_screen.dart';
import 'package:diary/presentation/screens/splash_screen/onboarding.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });

    return  Scaffold(
     
      body: Center(
        child: Image(
          image: Theme.of(context).brightness == Brightness.light ? const AssetImage(
            
            'assets/images/forever_memories_logo/forever_memories_logo_black.png',
          ) : const AssetImage(
            
            'assets/images/forever_memories_logo/forever_memories_logo_white.png',
          )
        ),
      ),
    );
  }
}
