import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ResponsiveUtils {
  // Customization screen
  double _customizationScreenHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    
    // Check if the screen height is less than 1920
    if (screenHeight < 820) {
      return 20.h;
    } else {
      // Default case for screen height greater than or equal to 1920
      return 15.h;
    }
  }
 
 double customizationScreenHeight(BuildContext context) {
    return _customizationScreenHeight(context);
  }

}
