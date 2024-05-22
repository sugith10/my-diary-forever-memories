import 'package:diary/presentation/pages/util/splash_screen_functions.dart';
import 'package:diary/presentation/utils/assets/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/get_theme_type.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
 State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SplashScreenController().setup(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child:  SvgPicture.asset(
        isDark(context) ? AppSvg.darkLogo : AppSvg.lightLogo,
        width: 150,
        height: 150,
      ),
        ),
      ),
    );
  }

  
}
