import 'package:diary/screens/account_screen/customization_screen/widget/theme_switch_card.dart';
import 'package:diary/screens/widget/appbar_with_back_button_only.dart';
import 'package:diary/screens/account_screen/widget/info_container.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomizationPage extends StatelessWidget {
  const CustomizationPage({super.key});

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
    
  ),
)
          ],
        ),
      ),
    );
  }
}
