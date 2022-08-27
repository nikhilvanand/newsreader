import 'package:flutter/material.dart';

class CommonDarkTheme {
  ThemeData themedata = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black54,
    primaryColorLight: Colors.black87,
    primaryColorDark: Colors.black, //blueGrey.shade900,
    primarySwatch: Colors.brown,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.brown,
      ),
    ),
    scaffoldBackgroundColor: Colors.black, //.shade900,
    textTheme: const TextTheme(
      headline5: TextStyle(fontSize: 18),
      bodyText1: TextStyle(fontSize: 16),
      bodyText2: TextStyle(fontSize: 16),
    ).apply(
      bodyColor: Colors.grey.shade200,
    ),
  );
}
