import 'package:diary/core/route/route_name/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/util/asset_path/app_lottie.dart';
import '../../../../view/util/get_theme_type.dart';

import '../../data/onboarding_content_data.dart';

import '../../util/onboarding_screen_size_cntrl.dart';
import '../../view_model/bloc/welcome_bloc/welcome_bloc.dart';
import '../widget/build_dot_ widget.dart';
import '../widget/skip_widget.dart';
import '../widget/welcome_button.dart';
import '../widget/welcome_content_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController pageController = PageController(initialPage: 0);
  final WelcomeContentData _welcomeContentList = WelcomeContentData();
  final WelcomePageSizeCntrl _welcomePageSizeCntrl = WelcomePageSizeCntrl();

  final WelcomeBloc _welcomeBloc = WelcomeBloc();

  @override
  dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<WelcomeBloc, WelcomeState>(
      bloc: _welcomeBloc,
      listener: (context, state) {
        if (state is WelcomeToHomeState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.home,
            (_) => false,
          );
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: WelcomePageSizeCntrl().calculateLottieSizedbox(
                screenHeight: size.height,
                screenWidth: size.width,
              ),
            ),
            Lottie.asset(
              isDark(context) ? AppLottie.welcomeLight : AppLottie.welcomeDark,
              width: double.infinity,
            ),
            WelcomeContentWidget(
              welcomeBloc: _welcomeBloc,
              pageController: pageController,
              contentList: _welcomeContentList.contentList,
              welcomePageSizeCntrl: _welcomePageSizeCntrl,
              size: size,
            ),
            BuidDot(
              context: context,
              welcomeBloc: _welcomeBloc,
              lengtth: 3,
            ),
            WelcomeButton(
              welcomeBloc: _welcomeBloc,
              welcomeContentList: _welcomeContentList,
              pageController: pageController,
            ),
            SkipWidget(callback: () {
              _welcomeBloc.add(WelcomeToHomeEvent());
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
