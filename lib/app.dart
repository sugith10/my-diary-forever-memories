import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_view.dart';
import 'core/presentation/provider/calendar_scrn_prvdr.dart';
import 'core/presentation/provider/main_scrn_prvdr.dart';
import 'core/presentation/provider/onboarding_scrn_prvdr.dart';
import 'core/presentation/provider/theme_select_prvdr.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => OnboardingScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CalenderScreenProvider(),
        ),
      ],
      child: const MyAppView(),
    );
  }
}