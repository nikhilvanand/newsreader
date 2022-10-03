import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonDarkTheme {
  ThemeData themedata = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black54,
    primaryColorLight: Colors.black87,
    primaryColorDark: Color.fromARGB(255, 255, 255, 255), //blueGrey.shade900,
    primarySwatch: Colors.grey,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
/*     textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.brown,
      ),
    ) */
    scaffoldBackgroundColor: Colors.black, //.shade900,
    textTheme: TextTheme(
      headline5: GoogleFonts.ubuntu(fontSize: 18),
      bodyText1: GoogleFonts.ubuntu(fontSize: 16),
      bodyText2: GoogleFonts.ubuntu(fontSize: 16),
      subtitle1: GoogleFonts.ubuntu(fontSize: 15),
      subtitle2: GoogleFonts.ubuntu(fontSize: 12),
      caption: GoogleFonts.ubuntu(fontSize: 18, color: Colors.black),
    ).apply(
      bodyColor: Colors.grey.shade200,
    ),
  );
}
