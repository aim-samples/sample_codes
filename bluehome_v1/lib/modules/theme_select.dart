import 'package:flutter/material.dart';
enum ThemeKeys {lightRed, lightGreen, lightBlue, darkRed, darkGreen, darkBlue}
class CustomThemes{
  static final ThemeData lightRed = ThemeData(
      brightness: Brightness.light,
      accentColor: Colors.red[200]);
  static final ThemeData lightGreen = ThemeData(
      brightness: Brightness.light,
      accentColor: Colors.green[200]);
  static final ThemeData lightBlue = ThemeData(
      brightness: Brightness.light,
      accentColor: Colors.blue[200]);
  static final ThemeData darkRed = ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.red[200]);
  static final ThemeData darkGreen = ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.green[200]);
  static final ThemeData darkBlue = ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.blue[200]);
  static ThemeData getThemeFromKey(ThemeKeys themeKey ){  switch (themeKey) {
    case ThemeKeys.lightRed   : return lightRed   ;
    case ThemeKeys.lightGreen : return lightGreen ;
    case ThemeKeys.lightBlue  : return lightBlue  ;
    case ThemeKeys.darkRed    : return darkRed    ;
    case ThemeKeys.darkGreen  : return darkGreen  ;
    case ThemeKeys.darkBlue   : return darkBlue   ;
    default                   : return lightRed   ;}}
}