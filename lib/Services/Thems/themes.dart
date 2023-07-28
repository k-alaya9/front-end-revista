import 'package:flutter/material.dart';

class Themes {
  static final dark =ThemeData(
    brightness: Brightness.dark,
      primaryColor:Color(0xFF00BFAF),
      accentColor: Colors.deepOrange[200],
    backgroundColor: const Color(0xff121212),
    textTheme: const TextTheme(
      headline1:  TextStyle(
        fontFamily: 'SF-Compact-Rounded',
          fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      bodyText1: TextStyle(
        fontFamily: 'Roboto'
      ),
      bodyText2: TextStyle(
        fontFamily: 'Cairo'
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    )
  );
  static final light =ThemeData(
    brightness: Brightness.light,
      primaryColor:Color(0xFF00BFAF),
      accentColor: Colors.deepOrange[200],
    backgroundColor:  Color(0xfff9f9f9),
    textTheme: const TextTheme(
      headline1:  TextStyle(
        fontFamily: 'SF-Compact-Rounded',
          fontSize: 20,
          fontWeight: FontWeight.bold
      ),
      bodyText1: TextStyle(
        fontFamily: 'Roboto'
      ),
      bodyText2: TextStyle(
        fontFamily: 'Cairo'
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    )
  );
}