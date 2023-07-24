import 'package:flutter/material.dart';

class Themes {
  static final dark =ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple[400],
    accentColor: const Color(0xffF49741),
    backgroundColor: const Color(0xff1F1B21),
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
    primaryColor:Colors.deepPurple[400],
    accentColor: const Color(0xffF4974a),
    backgroundColor:  Color(0xfff9f7fc),
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