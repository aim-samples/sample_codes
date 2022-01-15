import 'package:flutter/material.dart';
import 'package:projects_management/values/values.dart';

class Themes{
  static ThemeData lightBlueTheme  = Themes.createTheme(Brightness.light,  Colors.blue[800]);
  static ThemeData darkBlueTheme   = Themes.createTheme(Brightness.dark,   Colors.blue[800]);
  static ThemeData lightPinkTheme  = Themes.createTheme(Brightness.light,  Colors.pink[400]);
  static ThemeData darkPinkTheme   = Themes.createTheme(Brightness.dark,   Colors.pink[400]);
  static ThemeData lightRedTheme   = Themes.createTheme(Brightness.light,  Colors.red[400]);
  static ThemeData darkRedTheme    = Themes.createTheme(Brightness.dark,   Colors.red[400]);
  static ThemeData createTheme(Brightness _brightness, Color _accentColor) => ThemeData(
    brightness: _brightness,
    accentColor: _accentColor,
    scaffoldBackgroundColor: _brightness == Brightness.dark ? Colors.black : Colors.white,
    fontFamily: Strings.font_raleway,
    appBarTheme: _brightness == Brightness.dark ? //if brightness dark
    ThemeData.dark().appBarTheme.copyWith(
        color: Colors.grey[800],
        iconTheme: ThemeData.light().iconTheme.copyWith(
            color: Colors.white),
        textTheme: ThemeData.light().textTheme.copyWith(
            title: ThemeData.light().textTheme.title.copyWith(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: Strings.font_raleway))) ://else
    ThemeData.light().appBarTheme.copyWith(
        color: Colors.white,
        iconTheme: ThemeData.light().iconTheme.copyWith(
            color: Colors.grey[800]),
        textTheme: ThemeData.light().textTheme.copyWith(
            title: ThemeData.light().textTheme.title.copyWith(
                color: Colors.grey[800],
                fontSize: 20.0,
                fontFamily: Strings.font_raleway))),
    tabBarTheme: _brightness == Brightness.dark ?
    ThemeData.dark().tabBarTheme.copyWith(
        labelStyle: TextStyle(
            fontFamily: Strings.font_raleway)) :
    ThemeData.light().tabBarTheme.copyWith(
        labelColor: Colors.grey[800],
        labelStyle: TextStyle(
            fontFamily: Strings.font_raleway)),
    snackBarTheme: SnackBarThemeData(
        actionTextColor: _brightness == Brightness.light ? Colors.white : Colors.grey[900]),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
//      backgroundColor: _brightness == Brightness.dark ? Colors.grey[800] : Colors.white,
//      foregroundColor: _accentColor,
    ),
  );
}