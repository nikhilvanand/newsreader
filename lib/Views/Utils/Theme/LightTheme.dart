import 'package:flutter/material.dart';

class CommonLightTheme {
  ThemeData themedata = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black54,
    primaryColorLight: Colors.black87,
    primaryColorDark: Colors.blueGrey.shade300,
    primarySwatch: Colors.brown,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.brown,
      ),
    ),
    scaffoldBackgroundColor: Colors.blueGrey.shade300,
    textTheme: const TextTheme(
      headline5: TextStyle(fontSize: 18),
      bodyText1: TextStyle(fontSize: 16),
      bodyText2: TextStyle(fontSize: 16),
    ).apply(
      bodyColor: Colors.white,
    ),
  );
}
