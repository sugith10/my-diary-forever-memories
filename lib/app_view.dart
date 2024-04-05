import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'core/presentation/providers/theme_select_prvdr.dart';
import 'core/presentation/pages/pages/main_page/main_page.dart';
import 'core/presentation/pages/pages/splash_page/splash_page.dart';
import 'core/presentation/theme/app_theme.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});
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
