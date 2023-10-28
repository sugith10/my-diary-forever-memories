import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/provider_mainscreen.dart';
import 'package:diary/screens/screen0_welcome/onboarding.dart';
import 'package:diary/screens/screen0_welcome/provider_onboarding.dart';
import 'package:diary/screens/screen2_calendar/provider_calendar.dart';
import 'package:diary/screens/screen0_welcome/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(DiaryEntryAdapter().typeId)) {
    Hive.registerAdapter(DiaryEntryAdapter());
  }
  runApp(
    MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (context) => Changer(),
    ),
    ChangeNotifierProvider(
      create: (context) => OnboardingState(),
    ),
    ChangeNotifierProvider(
      create: (context) => MainScreenProvider(),
    ),
    
    
  ],
  child: MyApp(),
),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
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
      },
    );
  }
}
