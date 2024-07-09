import 'package:diary/core/theme/app_theme/app_theme.dart';
import 'package:diary/feature/customization/view_model/bloc/theme_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'core/route/app_route_package.dart';
import 'core/route/route_name/route_name.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});
  @override
  Widget build(BuildContext context) {
    final themeBloc = context.watch<ThemeBloc>();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      minTextAdapt: false,
      fontSizeResolver: FontSizeResolvers.radius,
      child: Builder(builder: (context) {
        return ToastificationWrapper(
          child: MaterialApp(
                title: 'My Diary',
                theme: AppLightTheme().theme,
                darkTheme: AppDarkTheme().theme,
                themeMode: themeBloc.isDarkMode
                    ? ThemeMode.dark
                    : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                initialRoute: RouteName.initial,
                onGenerateRoute: AppRoute.generateRoute,
              ),
        );
      }),
    );
  }
}
