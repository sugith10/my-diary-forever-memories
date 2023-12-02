import 'package:diary/infrastructure/providers/provider_theme.dart';
import 'package:diary/presentation/screens/account_screen/customization_screen/widget/theme_switch_card.dart';
import 'package:diary/presentation/screens/account_screen/customization_screen/widget/theme_switch_card_body.dart';
import 'package:diary/presentation/screens/widget/appbar_with_back_button_only_common.dart';
import 'package:diary/presentation/screens/account_screen/widget/info_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CustomizationPage extends StatefulWidget {
  const CustomizationPage({super.key});

  @override
  _CustomizationPageState createState() => _CustomizationPageState();
}

class _CustomizationPageState extends State<CustomizationPage> {
  int? selectedTheme;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            const InfoContainer(
              title: "Customization",
              description:
                  "Personalize your diary experience by customizing settings. Tailor the app to match your preferences and make each entry uniquely yours.",
            ),
            ThemeSwitchCard(
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
                    groupValue: selectedTheme,
                    onChanged: (value) {
                      setState(
                        () {
                          selectedTheme = value;
                       Provider.of<ThemeNotifier>(context, listen: false).switchLight();
                          print('white');
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const ThemeSwitchCardBody(
                      text: 'Day', color: Color.fromARGB(255, 255, 255, 255)),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            ThemeSwitchCard(
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
                    groupValue: selectedTheme,
                    onChanged: (value) {
                      setState(() {
                        selectedTheme = value;
                         Provider.of<ThemeNotifier>(context, listen: false).switchDark();
                        print('dark');
                      });
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const ThemeSwitchCardBody(
                    text: 'Night',
                    color: Color.fromARGB(255, 38, 38, 38),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
