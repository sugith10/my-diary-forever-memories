import 'package:diary/screens/widget/appbar_bottom.dart';
import 'package:diary/screens/profile_screen/widget/info_container.dart';
import 'package:flutter/material.dart';

class CustomizationPage extends StatelessWidget {
  const CustomizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          children: [
            InfoContainer(
              title: "Customization",
              description:
                  "Personalize your diary experience by customizing settings. Tailor the app to match your preferences and make each entry uniquely yours.",
            )
          ],
        ),
      ),
    );
  }
}
