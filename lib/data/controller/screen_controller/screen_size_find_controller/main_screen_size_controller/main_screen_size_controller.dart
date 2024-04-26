class MainScreenSizeCntrl {
  double _calculateBottomNavFontSize({required double screenHeight,required double screenWidth}) {
    double fontSize;

    if (screenHeight >= 700 &&
        screenHeight < 750 &&
        screenWidth >= 320 &&
        screenWidth < 360) {
      fontSize = 8.5;
    } else if (screenHeight >= 700 &&
        screenHeight < 780 &&
        screenWidth >= 300 &&
        screenWidth < 400) {
      fontSize = 8.5;
    } else if (screenHeight >= 780 &&
        screenHeight < 800 &&
        screenWidth >= 375 &&
        screenWidth < 411) {
      fontSize = 8.7;
    } else if (screenHeight >= 800 &&
        screenHeight < 820 &&
        screenWidth >= 375 &&
        screenWidth < 411) {
      fontSize = 8.8;
    } else if (screenHeight >= 820 &&
        screenHeight < 850 &&
        screenWidth >= 411 &&
        screenWidth < 440) {
      fontSize = 8.9;
    } else if (screenHeight >= 850 &&
        screenHeight < 900 &&
        screenWidth >= 411 &&
        screenWidth < 480) {
      fontSize = 9;
    } else if (screenHeight >= 900 && screenWidth >= 480) {
      fontSize = 10.0;
    } else {
      fontSize = 10.0;
    }

    fontSize * 0.01;

    return fontSize;
  }


  double calculateBottomNavFontSize({required double screenHeight,required double screenWidth}){
    return _calculateBottomNavFontSize(screenHeight:  screenHeight,screenWidth:  screenWidth);
  }
}
