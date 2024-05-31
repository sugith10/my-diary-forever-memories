
import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';

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
              color: AppColor.primary.color,
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