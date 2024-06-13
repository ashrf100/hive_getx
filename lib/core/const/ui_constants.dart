import 'package:flutter/material.dart';

class UI {
  // Colors
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryLight = Color(0xFF9D46FF);
  static const Color primaryDark = Color(0xFF0A00B6);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryLight = Color(0xFF66FFF9);
  static const Color secondaryDark = Color(0xFF00A896);
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color surface = Color(0xFFFFFFFF); // White surface
  static const Color error = Color(0xFFB00020); // Red
  static const Color gray = Color(0xFF757575); // Gray for subtitles
  static const Color black = Color(0xFF000000); // Black for titles
  static const Color onPrimary = Color(0xFFFFFFFF); // White on primary
  static const Color onSecondary = Color(0xFF000000); // Black on secondary
  static const Color onError = Color(0xFFFFFFFF); // White on error

  // Text Styles
  static const TextStyle h1 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: black,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: black,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: black,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: gray,
  );

  static const TextStyle btn = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const double padSm = 8.0;
  static const double padMd = 16.0;
  static const double padLg = 32.0;

  static const double radSm = 4.0;
  static const double radMd = 8.0;
  static const double radLg = 16.0;

  static const double iconSm = 16;
  static const double iconMd = 24.0;
  static const double iconLg = 48.0;
}
