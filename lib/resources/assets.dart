import 'package:flutter/material.dart';

// Colors
const Color primaryColor = Color(0xFF72C676);

const Color backgroundColor = Color(0xFFFFFFFF);
const Color charcoalColor = Color(0xFF373A36);
const Color lightcharcoalColor = Color(0xFF9A9B9A);

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
