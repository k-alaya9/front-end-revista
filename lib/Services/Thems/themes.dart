import 'package:flutter/material.dart';

class Themes {
  static final dark =ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xff705DF2),
    accentColor: const Color(0xffF49741),
    backgroundColor: const Color(0xff1F1B24),
    splashColor: const Color(0xf5f49745),
    textTheme: const TextTheme(
      headline1:  TextStyle(
        fontFamily: 'Comic Neue'
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
    primaryColor: const Color(0xff705DFa),
    accentColor: const Color(0xffF4974a),
    backgroundColor: const Color(0xffF2E7FE),
    splashColor: const Color(0xf5f49745),
    textTheme: const TextTheme(
      headline1:  TextStyle(
        fontFamily: 'Comic Neue'
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