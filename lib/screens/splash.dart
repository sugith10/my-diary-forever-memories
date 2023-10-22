import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
     Navigator.pushReplacementNamed(context, '/onboarding');
    });

    return  
      SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body:Center(
            child: Lottie.network('https://lottie.host/ec4cd8cb-974f-47ed-8383-204312ab3558/0Q9zqo3Cnt.json')
            // Image(image: AssetImage('images/first-img.png')
            )
            
          )
        
      );
    
  }
}
