import 'package:diary/core/util/asset_path/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/route/route_name/route_name.dart';
import '../../../../view/util/get_theme_type.dart';
import '../../view_model/bloc/splash_bloc/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _bloc = SplashBloc();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is SplashTowelcomeState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.welcome,
            (route) => false,
          );
        }
        if (state is SplashToHomeState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.welcome,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: SvgPicture.asset(
              isDark(context) ? AppSvg.darkLogo : AppSvg.lightLogo,
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}
