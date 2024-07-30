import 'package:diary/core/theme/app_color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import 'package:diary/core/widget/app_snack_bar.dart';
import 'package:diary/feature/customization/model/theme_model.dart';
import 'package:diary/feature/customization/view_model/bloc/theme_bloc_bloc.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../util/test_notifiction_util.dart';
import '../widget/info_container.dart';
import '../widget/theme_card.dart';

class CustomizationPage extends StatelessWidget {
  const CustomizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.watch<ThemeBloc>();
    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        if (state is ThemeCurrentState) {
          AppSnackBar.show(
            context: context,
            title: ThemeModeNotificationUtil.show(state.theme).title,
            description:
                ThemeModeNotificationUtil.show(state.theme).description,
            type: ToastificationType.success,
          );
        }
      },
      child: Scaffold(
        appBar: const DefaultAppBar(),
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
              ThemeCard(
                activeColor: Theme.of(context).brightness == Brightness.light
                    ? AppDarkColor.instance.background
                    : AppLightColor.instance.background,
                onTap: () {
                  themeBloc.add(const ThemeSetEvent(theme: ThemeModel.day));
                },
                value: 1,
                groupValue: themeBloc.value,
                themeColor: AppLightColor.instance.background,
                title: 'Day',
              ),
              const SizedBox(
                height: 25,
              ),
              ThemeCard(
                activeColor: Theme.of(context).brightness == Brightness.light
                    ? AppDarkColor.instance.background
                    : AppLightColor.instance.background,
                onTap: () {
                  themeBloc.add(const ThemeSetEvent(theme: ThemeModel.night));
                },
                value: 2,
                groupValue: themeBloc.value,
                themeColor: AppDarkColor.instance.background,
                title: 'Night',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
