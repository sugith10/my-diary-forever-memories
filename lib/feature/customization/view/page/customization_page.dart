import 'package:diary/feature/customization/model/theme_model.dart';
import 'package:diary/feature/customization/view_model/bloc/theme_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/widget/app_custom_app_bar.dart';
import '../widget/info_container.dart';
import '../widget/theme_card.dart';
import '../../../../view/page/customization_page/widget/theme_switch_card_body.dart';

class CustomizationPage extends StatelessWidget {
  const CustomizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.watch<ThemeBloc>();
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 50),
            const InfoContainer(
              title: "Customization",
              description:
                  "Personalize your diary experience by customizing settings. Tailor the app to match your preferences and make each entry uniquely yours.",
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                themeBloc.add(const ThemeSetEvent(theme: ThemeModel.day));
                HapticFeedback.mediumImpact();
              },
              child: ThemeCard(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Radio(
                      value: 1,
                      activeColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 9, 9, 9)
                              : const Color.fromRGBO(255, 255, 255, 1),
                      groupValue: themeBloc.value,
                      onChanged: (_) {
                        themeBloc
                            .add(const ThemeSetEvent(theme: ThemeModel.day));
                      },
                    ),
                    const SizedBox(width: 20),
                    const ThemeCardBody(
                      text: 'Day',
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                themeBloc.add(const ThemeSetEvent(theme: ThemeModel.night));
                HapticFeedback.mediumImpact();
              },
              child: ThemeCard(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Radio(
                      value: 2,
                      activeColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 9, 9, 9)
                              : const Color.fromRGBO(255, 255, 255, 1),
                      groupValue: themeBloc.value,
                      onChanged: (_) {
                        themeBloc
                            .add(const ThemeSetEvent(theme: ThemeModel.night));
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const ThemeCardBody(
                      text: 'Night',
                      color: Color.fromARGB(255, 38, 38, 38),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
