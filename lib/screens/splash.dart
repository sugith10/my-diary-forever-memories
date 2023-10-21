import 'package:flutter/material.dart';


class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return  
      SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body:Center(
            child: Image(image: AssetImage('images/first-img.png'))
          )
        ),
      );
    
  }
}
