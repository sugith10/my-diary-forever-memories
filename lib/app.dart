import 'package:diary/feature/customization/view_model/bloc/theme_bloc_bloc.dart';
import 'package:diary/feature/diary/data/diary_data.dart';
import 'package:diary/feature/diary/repository/diary_repo.dart';
import 'package:diary/feature/diary/view_model/bloc/diary_bloc/create_diary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'app_view.dart';
import 'feature/customization/data/theme_data.dart';
import 'feature/customization/repository/theme_repo.dart';
import 'feature/onboarding/view_model/provider/onboarding_scrn_prvdr.dart';
import 'feature/diary/view_model/provider/calendar_scrn_prvdr.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //BlocF
        BlocProvider(
            create: (context) => ThemeBloc(AppThemeRepo(AppThemeData()))),
        BlocProvider(create: (context) => DiaryBloc(DiaryRepo(DiaryData()))),
        //Provider

        ChangeNotifierProvider(
          create: (context) => WelcomeProvider(),
        ),
       
        ChangeNotifierProvider(
          create: (context) => CalenderPageProvider(),
        ),
      ],
      child: const MyAppView(),
    );
  }
}
