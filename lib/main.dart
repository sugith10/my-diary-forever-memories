import 'package:diary/model/app_preference_db_model.dart';
import 'package:diary/model/archive_db_model.dart';
import 'package:diary/model/diary_entry.dart';
import 'package:diary/model/profile_details.dart';
import 'package:diary/model/savedlist_db_model.dart';
import 'package:diary/provider/theme_select_prvdr.dart';
import 'package:diary/view/screens/main_screen/main_screen.dart';
import 'package:diary/view/screens/splash_screen/splash_screen.dart';
import 'package:diary/view/theme/app_theme.dart';
import 'package:diary/provider/main_scrn_prvdr.dart';
import 'package:diary/provider/onboarding_scrn_prvdr.dart';
import 'package:diary/provider/calendar_scrn_prvdr.dart';
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
  await Hive.openBox<DiaryEntry>('diaryEntryBox');

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
  await Hive.openBox<ArchiveDiary>('archiveDiaryBox');

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
          create: (context) => OnboardingScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CalenderScreenProvider(),
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
        title: 'My Diary',
        theme: AppTheme().lightMode,
        darkTheme: AppTheme().darkMode,
        themeMode: Provider.of<ThemeNotifier>(context).isDarkMode
            ? ThemeMode.dark
            : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const Splash(),
       
          '/main': (context) => MainScreen(),
        },
      ),
    );
  }
}
