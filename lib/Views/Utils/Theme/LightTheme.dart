import 'package:flutter/material.dart';

class CommonLightTheme {
  ThemeData themedata = ThemeData(
    canvasColor: Color(0xFF233d4d),
    brightness: Brightness.light,
    primaryColor: Colors.black54,
    primaryColorLight: Colors.white,
    primaryColorDark: Color.fromARGB(255, 0, 0, 0),
    primarySwatch: Colors.brown,
    backgroundColor: Colors.blueGrey.shade900,
    splashColor: Colors.brown.shade700,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
/*     textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Colors.brown.shade900),
    ), */
    scaffoldBackgroundColor: Color.fromARGB(255, 228, 228, 228),
    textTheme: const TextTheme(
      headline5: TextStyle(fontSize: 18),
      bodyText1: TextStyle(fontSize: 16),
      bodyText2: TextStyle(fontSize: 16),
      subtitle1: TextStyle(fontSize: 15),
      subtitle2: TextStyle(fontSize: 12),
      caption: TextStyle(fontSize: 18, color: Colors.black),
    ).apply(
      bodyColor: Colors.grey.shade900,
    ),
  );
}
