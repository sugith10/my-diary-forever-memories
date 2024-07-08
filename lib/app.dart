import 'package:diary/feature/customization/view_model/bloc/theme_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'app_view.dart';
import 'feature/customization/data/theme_data.dart';
import 'feature/customization/repository/theme_repo.dart';
import 'feature/onboarding/view_model/provider/onboarding_scrn_prvdr.dart';
import 'view_model/providers/calendar_scrn_prvdr.dart';
import 'view_model/providers/main_scrn_prvdr.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
            create: (context) => ThemeBloc(AppThemeRepo(AppThemeData()))),

        //Provider
      
        ChangeNotifierProvider(
          create: (context) => WelcomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainNavigationMenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CalenderPageProvider(),
        ),
      ],
      child: const MyAppView(),
    );
  }
}
