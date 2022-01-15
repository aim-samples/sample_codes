import 'package:bluehome/values/values.dart';
import 'package:flutter/material.dart';
class Themes {
  static ThemeData lightGreenTheme = Themes.createTheme(
    accentColor: Colors.green[300],
    brightness: Brightness.light,
    fabForegroundColor: Colors.white,
    primaryColor: Colors.green[900],);
  static ThemeData darkGreenTheme = Themes.createTheme(
    accentColor: Colors.green[300],
    brightness: Brightness.dark,
    fabForegroundColor: Colors.white,
    primaryColor: Colors.green[800],);
  static ThemeData lightBlueTheme = Themes.createTheme(
    accentColor: Colors.blue[300],
    brightness: Brightness.light,
    fabForegroundColor: Colors.white,
    primaryColor: Colors.blue[900],);
  static ThemeData darkBlueTheme = Themes.createTheme(
    accentColor: Colors.blue[300],
    brightness: Brightness.dark,
    fabForegroundColor: Colors.white,
    primaryColor: Colors.blue[800],);
  static ThemeData createTheme({
    Color accentColor,
    Brightness brightness,
    Color fabForegroundColor,
    Color primaryColor}) => ThemeData(
    scaffoldBackgroundColor: scaffoldColor(brightness),
    accentColor: accentColor,
    brightness: brightness,
    primaryColor: primaryColor,
    primaryColorDark: primaryColor,
    fontFamily: Fonts.raleway,
    floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: fabForegroundColor),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
      color: scaffoldColor(brightness),
      elevation: 0,
      textTheme: ThemeData.light().textTheme.copyWith(
        title: ThemeData.light().textTheme.title.copyWith(
          fontFamily: Fonts.roboto,
          letterSpacing: 1,
          fontSize: 20,
          color: brightness == Brightness.dark ? accentColor : primaryColor,),),
      iconTheme: ThemeData.light().iconTheme.copyWith(
        color: brightness == Brightness.dark ? accentColor : primaryColor,
      ),
    ),
    cursorColor: brightness == Brightness.dark ? accentColor : primaryColor
  );
}
Color scaffoldColor(Brightness brightness) => brightness == Brightness.dark ?
Colors.grey[900] : Colors.white;
Color chooseColorFromBrightness(context) =>
    Theme.of(context).brightness == Brightness.dark ?
    Theme.of(context).accentColor :
    Theme.of(context).primaryColor;
Color chooseLightTextColorFromBrightness(context) =>
    Theme.of(context).brightness == Brightness.dark ?
    Colors.grey[400] :
    Colors.grey[600];

class CustomTextStyle {
  static TextStyle boldWithSpace2         = TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 2,);
  //firaCode
  static TextStyle firaCode               = TextStyle(
    fontFamily: Fonts.firacode,);
  static TextStyle firaCodeBold           = TextStyle(
    fontFamily: Fonts.firacode,
    fontWeight: FontWeight.bold,);
  static TextStyle firaCodeBoldWithSpace2 = TextStyle(
    fontFamily: Fonts.firacode,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,);
  static TextStyle firaCodeWithSpace2     = TextStyle(
    fontFamily: Fonts.firacode,
    letterSpacing: 2,);
  //raleway
  static TextStyle raleway                = TextStyle(
    fontFamily: Fonts.raleway,);
  static TextStyle ralewayBold            = TextStyle(
    fontFamily: Fonts.raleway,
    fontWeight: FontWeight.bold,);
  static TextStyle ralewayBoldWithSpace2      = TextStyle(
    fontFamily: Fonts.raleway,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,);
  static TextStyle ralewayWithSpace2      = TextStyle(
    fontFamily: Fonts.raleway,
    letterSpacing: 2,);
  //roboto
  static TextStyle roboto                 = TextStyle(
    fontFamily: Fonts.roboto,);
  static TextStyle robotoBoldWithSpace2   = TextStyle(
    fontFamily: Fonts.roboto,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,);
  static TextStyle robotoWithSpace2       = TextStyle(
    fontFamily: Fonts.roboto,
    letterSpacing: 2,);
}