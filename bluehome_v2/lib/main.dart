
import 'package:bluehome/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:bluehome/values/values.dart';
import 'package:flutter/services.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override Widget build(BuildContext context) {
//  hides only status bar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: Strings.app_name,
      theme: Themes.lightBlueTheme,
      darkTheme: Themes.darkBlueTheme,
      home: FieldsPage(),);
  }
}
