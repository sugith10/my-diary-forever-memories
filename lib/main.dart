import 'package:diary/models/diary_entry.dart';
import 'package:diary/models/profile_details.dart';
import 'package:diary/screens/home/mainscreen.dart';
import 'package:diary/screens/home/provider_mainscreen.dart';
import 'package:diary/screens/screen0.1_auth/provider_auth.dart';
import 'package:diary/screens/screen0_welcome/onboarding.dart';
import 'package:diary/screens/screen0_welcome/provider_onboarding.dart';
import 'package:diary/screens/screen2_calendar/provider_calendar.dart';
import 'package:diary/screens/screen0_welcome/splash.dart';
import 'package:diary/screens/screen5_create/provider_create.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(DiaryEntryAdapter().typeId)) {
    Hive.registerAdapter(DiaryEntryAdapter());
  }
  await Hive.openBox<DiaryEntry>('_boxName');

  if (!Hive.isAdapterRegistered(ProfileDetailsAdapter().typeId)) {
    Hive.registerAdapter(ProfileDetailsAdapter());
  }
  await Hive.openBox<ProfileDetails>('_profileBoxName');



  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CreatePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Changer(),
        ),
        ChangeNotifierProvider(
          create: (context) => OnboardingState(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        theme: ThemeData(
          fontFamily: 'Satoshi',
          primaryColor: Colors.grey[300],
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => Splash(),
          '/onboarding': (context) => Onbording(
                onboardingState: Provider.of<OnboardingState>(context),
              ),
          '/main': (context) => MainScreen(),
        },
      ),
    );
  }
}
