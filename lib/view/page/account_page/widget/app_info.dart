import 'package:diary/core/theme/app_color/app_colors.dart';
import 'package:diary/utils/is_dark.dart';
import 'package:flutter/material.dart';

class AppInfoWidget extends StatelessWidget {
  const AppInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Made with ',
              style: TextStyle(fontSize: 18),
            ),
            Icon(
              Icons.favorite,
              color: IsDark.check(context)
                  ? AppDarkColor.instance.pageFour
                  : AppLightColor.instance.pageFour,
              size: 24.0,
            ),
            const Text(
              ' in India',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Text('© 2024 DayProduction® v1.4.2',
            style: TextStyle(fontSize: 15)),
      ],
    );
  }
}
