import 'package:diary/core/models/app_preference_db_model.dart';
import 'package:diary/core/models/archive_db_model.dart';
import 'package:diary/core/models/diary_entry.dart';
import 'package:diary/core/models/profile_details.dart';
import 'package:diary/core/models/savedlist_db_model.dart';
import 'package:diary/infrastructure/providers/provider_theme.dart';
import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:diary/presentation/screens/splash_screen/onboarding.dart';
import 'package:diary/presentation/screens/splash_screen/splash.dart';
import 'package:diary/presentation/theme/app_theme.dart';
import 'package:diary/infrastructure/providers/provider_mainscreen.dart';
import 'package:diary/infrastructure/providers/provider_onboarding.dart';
import 'package:diary/infrastructure/providers/provider_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  if (!Hive.isAdapterRegistered(SavedListAdapter().typeId)) {
    Hive.registerAdapter(SavedListAdapter());
  }
  await Hive.openBox<SavedList>('_savedListBoxName');

  if (!Hive.isAdapterRegistered(AppPreferenceAdapter().typeId)) {
    Hive.registerAdapter(AppPreferenceAdapter());
  }
  await Hive.openBox<AppPreference>('appPreferenceBox');

  if (!Hive.isAdapterRegistered(ArchiveDiaryAdapter().typeId)) {
    Hive.registerAdapter(ArchiveDiaryAdapter());
  }
  await Hive.openBox<ArchiveDiary>('archiveDiaryEntryBox');

   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeNotifier(),
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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        theme: AppTheme().lightMode,
        darkTheme: AppTheme().darkMode,
        themeMode: Provider.of<ThemeNotifier>(context).isDarkMode
            ? ThemeMode.dark
            : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const Splash(),
          '/onboarding': (context) => Onbording(
                onboardingState: Provider.of<OnboardingState>(context),
              ),
           '/main': (context) => MainScreen(),   
        },
      ),
    );
  }
}