import 'package:flutter/material.dart';

class Config {
  Config._(); //is a private constructor which prevents the class from being instantiated.
  static ValetBuddyColors colors = ValetBuddyColors();
  static ValetBuddyDomain domain = ValetBuddyDomain();
  static ValetBuddyImages images = ValetBuddyImages();

  static String companyName = 'Valet Buddy';
}

class ValetBuddyImages {
  // Images
  final String textLogo = 'assets/images/logo-with-text.png';
  final String whiteTextLogo = 'assets/images/logo-with-text-white.png';
  final String squareLogo = 'assets/images/logo-square.png';
  final String squareWhiteLogo = 'assets/images/logo-square-white.png';
}

class ValetBuddyDomain {
  final String scheme = 'http';
  final String host = '192.168.1.90:5000'; //Replace the IP with your own local IP
}

class ValetBuddyColors {
  static const Color const_backgroundColor = Color.fromARGB(255, 1, 32, 60);
  static const Color const_backgroundColorNav = Color.fromARGB(255, 1, 32, 60);
  static const Color const_iconColor = Color.fromARGB(255, 1, 255, 255);
  static const Color const_textColor = Color.fromARGB(200, 110, 110, 110);

  final textColor = const_textColor;
  final backgroundColor = const_backgroundColor;
  final backgroundColorNav = const_backgroundColorNav;
  final iconColor = const_iconColor;

  final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.redAccent,
    onPrimary: Colors.red,
    secondary: const_iconColor,
    onSecondary: Colors.blueAccent,
    error: Colors.orange,
    onError: Colors.orangeAccent,
    background: const_backgroundColor,
    onBackground: const_textColor,
    surface: const_backgroundColor,
    onSurface: const_textColor,
  );
}
