import 'package:diary/controller/database_controller/app_pref_db_controller.dart';
import 'package:diary/view/pages/account_screen/widget/info_container.dart';
import 'package:diary/view/pages/customization_screen/widget/theme_switch_card.dart';
import 'package:diary/view/pages/customization_screen/widget/theme_switch_card_body.dart';
import 'package:diary/view/pages/widget/appbar_with_back_button_only_common.dart';
import 'package:diary/core/presentation/provider/theme_select_prvdr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomizationPage extends StatefulWidget {
  const CustomizationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomizationPageState createState() => _CustomizationPageState();
}

class _CustomizationPageState extends State<CustomizationPage> {
  int? selectedTheme;

  @override
  void initState() {
    super.initState();
    AppPrefDatabaseManager().getThemePreference().then((preference) {
      if (preference != null) {
        setState(() {
          selectedTheme = preference.isDark == true ? 2 : 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const InfoContainer(
            title: "Customization",
            description:
                "Personalize your diary experience by customizing settings. Tailor the app to match your preferences and make each entry uniquely yours.",
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedTheme = 1;
                Provider.of<ThemeNotifier>(context, listen: false)
                    .switchLight();
              });
            },
            child: ThemeSwitchCard(
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
                      setState(() {
                        selectedTheme = value;
                        Provider.of<ThemeNotifier>(context, listen: false)
                            .switchLight();
                      });
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
          ),
          const SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedTheme = 2;
                Provider.of<ThemeNotifier>(context, listen: false).switchDark();
              });
            },
            child: ThemeSwitchCard(
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
                        Provider.of<ThemeNotifier>(context, listen: false)
                            .switchDark();
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
            ),
          ),
        ],
      ),
    );
  }
}
