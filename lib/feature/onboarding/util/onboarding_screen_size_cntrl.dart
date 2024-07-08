class WelcomePageSizeCntrl {
  double _calculateLottieSizedbox(
      {required double screenHeight, required double screenWidth}) {
    double sizedBox;

    if (screenHeight >= 700 &&
        screenHeight < 750 &&
        screenWidth >= 320 &&
        screenWidth < 400) {
      sizedBox = 0;
    } else if (screenHeight >= 750 &&
        screenHeight < 780 &&
        screenWidth >= 320 &&
        screenWidth < 410) {
      sizedBox = 10;
    } else if (screenHeight >= 780 &&
        screenHeight < 800 &&
        screenWidth >= 390 &&
        screenWidth < 450) {
      sizedBox = 20;
    } else if (screenHeight >= 800 &&
        screenHeight < 820 &&
        screenWidth >= 400 &&
        screenWidth < 480) {
      sizedBox = 35;
    } else if (screenHeight >= 820 &&
        screenHeight < 850 &&
        screenWidth >= 410 &&
        screenWidth < 480) {
      sizedBox = 40;
    } else if (screenHeight >= 850 &&
        screenHeight < 900 &&
        screenWidth >= 410 &&
        screenWidth < 480) {
      sizedBox = 50;
    } else if (screenHeight >= 850 && screenWidth >= 390) {
      sizedBox = 65;
    } else {
      sizedBox = 65;
    }

    sizedBox * 0.01;

    return sizedBox;
  }

  double calculateLottieSizedbox(
      {required double screenHeight, required double screenWidth}) {
    return _calculateLottieSizedbox(
        screenHeight: screenHeight, screenWidth: screenWidth);
  }

  double _calculateTitleFontSize(
      {required double screenHeight, required double screenWidth}) {
    double fontSize;

    if (screenHeight >= 700 &&
        screenHeight < 750 &&
        screenWidth >= 320 &&
        screenWidth < 400) {
      fontSize = 15.0;
    } else if (screenHeight >= 750 &&
        screenHeight < 780 &&
        screenWidth >= 360 &&
        screenWidth < 411) {
      fontSize = 16.0;
    } else if (screenHeight >= 780 &&
        screenHeight < 800 &&
        screenWidth >= 375 &&
        screenWidth < 411) {
      fontSize = 17.0;
    } else if (screenHeight >= 800 &&
        screenHeight < 820 &&
        screenWidth >= 375 &&
        screenWidth < 411) {
      fontSize = 18.0;
    } else if (screenHeight >= 820 &&
        screenHeight < 850 &&
        screenWidth >= 390 &&
        screenWidth < 411) {
      fontSize = 19.0;
    } else if (screenHeight >= 850 &&
        screenHeight < 900 &&
        screenWidth >= 411 &&
        screenWidth < 480) {
      fontSize = 20.0;
    } else if (screenHeight >= 850 && screenWidth >= 390) {
      fontSize = 22.0;
    } else {
      fontSize = 22.0;
    }

    fontSize * 0.01;

    return fontSize;
  }

  double calculateTitleFontSize(
      {required double screenHeight, required double screenWidth}) {
    return _calculateTitleFontSize( screenHeight: screenHeight, screenWidth: screenWidth);
  }

   double _calculateDescriptionFontSize( {required double screenHeight, required double screenWidth}) {
    double fontSize;
    if (screenHeight >= 700 &&
        screenHeight < 750 &&
        screenWidth >= 320 &&
        screenWidth < 400) {
      fontSize = 15.0;
    } else if (screenHeight >= 750 &&
        screenHeight < 780 &&
        screenWidth >= 320 &&
        screenWidth < 410) {
      fontSize = 16.0;
    } else if (screenHeight >= 780 &&
        screenHeight < 800 &&
        screenWidth >= 400 &&
        screenWidth < 450) {
      fontSize = 17.0;
    } else if (screenHeight >= 800 &&
        screenHeight < 820 &&
        screenWidth >= 400 &&
        screenWidth < 480) {
      fontSize = 17.5;
    } else if (screenHeight >= 820 &&
        screenHeight < 850 &&
        screenWidth >= 380 &&
        screenWidth < 400) {
      // log('SM A53');
      fontSize = 18.0;
    } else if (screenHeight >= 850 &&
        screenHeight < 900 &&
        screenWidth >= 410 &&
        screenWidth < 480) {
      // log('SM M21');
      fontSize = 18.0;
    } else if (screenHeight >= 900 && screenWidth >= 390) {
      fontSize = 22.0;
    } else {
      fontSize = 21.0;
    }

    fontSize * 0.01;

    return fontSize;
  }

double calculateDescriptionFontSize(
      {required double screenHeight, required double screenWidth}) {
    return _calculateDescriptionFontSize( screenHeight: screenHeight, screenWidth: screenWidth);
  }

}
