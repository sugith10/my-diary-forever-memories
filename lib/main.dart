import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/onboarding.dart';
import 'package:diary/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  
  if (!Hive.isAdapterRegistered(DiaryEntryAdapter().typeId)){
    Hive.registerAdapter(DiaryEntryAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
        primaryColor: Colors.white,
       appBarTheme: AppBarTheme(backgroundColor: Colors.white)
        
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // Set the initial route to your Splash screen
      routes: {
        '/splash': (context) => Splash(),
        '/onboarding': (context) => Onbording(),
        // Define routes for other screens as needed
      },
    );
  }
}