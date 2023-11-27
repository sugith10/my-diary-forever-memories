import 'package:diary/screens/account_screen/customization_screen/widget/theme_switch_card.dart';
import 'package:diary/screens/widget/appbar_with_back_button_only.dart';
import 'package:diary/screens/account_screen/widget/info_container.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomizationPage extends StatefulWidget {
  const CustomizationPage({Key? key}) : super(key: key);

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
                  Radio(
                    value: 1,
                    groupValue: selectedTheme,
                    onChanged: (value) {
                      setState(() {
                        selectedTheme = value as int?;
                      });
                    },
                  ),
                  Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Day'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 4.h,),
            ThemeSwitchCard(
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Radio(
                    value: 2,
                    groupValue: selectedTheme,
                    onChanged: (value) {
                      setState(() {
                        selectedTheme = value as int?;
                      });
                    },
                  ),
                  SizedBox(width: 20,),
                  Column( 
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Night'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 50,
                          color: Colors.amber,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
