import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/onboarding_content_data.dart';
import '../../view_model/bloc/welcome_bloc/welcome_bloc.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({
    super.key,
    required this.welcomeBloc,
    required this.welcomeContentList,
    required this.pageController,
  });

  final WelcomeBloc welcomeBloc;
  final WelcomeContentData welcomeContentList;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          if (welcomeBloc.index != welcomeContentList.contentList.length - 1) {
            pageController.nextPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.bounceIn,
            );
          } else {
            welcomeBloc.add(WelcomeToHomeEvent());
          }
        },
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
          fixedSize: const Size(double.infinity, 50),
        ),
        child: FadeInUp(
          delay: const Duration(milliseconds: 600),
          duration: const Duration(milliseconds: 700),
          child: BlocBuilder<WelcomeBloc, WelcomeState>(
            bloc: welcomeBloc,
            builder: (context, state) {
              return Text(
                welcomeBloc.index == welcomeContentList.contentList.length - 1
                    ? "Continue"
                    : "Next",
              );
            },
          ),
        ),
      ),
    );
  }
}
