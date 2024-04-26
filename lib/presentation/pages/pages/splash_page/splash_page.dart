import 'package:diary/presentation/pages/util/splash_screen_functions.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {

   SplashScreenController().setup(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
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
      ),
    );
  }
}
