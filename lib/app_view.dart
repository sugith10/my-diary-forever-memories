import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'presentation/page/navigation_menu/main_page.dart';
import 'presentation/page/splash_page/splash_page.dart';
import 'presentation/providers/theme_select_prvdr.dart';
import 'presentation/theme/app_theme.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      minTextAdapt: false,
      fontSizeResolver: FontSizeResolvers.radius,
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'My Diary',
          theme: AppTheme().lightMode,
          darkTheme: AppTheme().darkMode,
          themeMode: Provider.of<ThemeNotifier>(context).isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashPage(),
            '/main': (context) => MainScreen(),
          },
        );
      }),
    );
  }
}
