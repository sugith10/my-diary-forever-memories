import 'package:diary/presentation/pages/util/splash_screen_functions.dart';
import 'package:diary/presentation/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          child: _logo(context),
        ),
      ),
    );
  }

  SvgPicture _logo(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return SvgPicture.asset(
        MyAppAssets.lightScreenLogo,
        width: 150,
        height: 150,
      );
    } else {
      return SvgPicture.asset(
        MyAppAssets.darkScreenLogo,
        width: 150,
        height: 150,
      );
    }
  }
}
