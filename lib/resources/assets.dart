import 'package:flutter/material.dart';

// Colors
const Color primaryColor = Color(0xFF72C676);
const Color darkPrimaryColor = Color(0xFF5CB260);

const Color backgroundColor = Color(0xFFFFFFFF);
const Color charcoalColor = Color(0xFF373A36);
const Color lightcharcoalColor = Color(0xFF9A9B9A);
const Color orangePastelColor = Color(0xFFffd294);
const Color reducedColor = Color(0xFFF16978);

// Asset paths

const String appLogoPath = 'assets/images/app-logo.png';
const String appIconPath = 'assets/images/app-icon-green.png';
const String onboardingVideoPath = 'assets/videos/onboarding.mp4';

// https://medium.com/@filipvk/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

const pingnaShopCardShape = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(12.0),
    bottomLeft: Radius.circular(12.0),
  ),
);

const pingnaShopTitleShape = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(12.0),
    bottomLeft: Radius.circular(12.0),
  ),
);

const pingnaButtonShape = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(12.0),
    bottomRight: Radius.circular(12.0),
  ),
);

const pingnaShopAppBarShape = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(25.0),
    topRight: Radius.circular(25.0),
  ),
);

const pingnaReducedShape = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(12.0),
    topRight: Radius.circular(12.0),
  ),
);

const pingnaProductShape = const RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
);
