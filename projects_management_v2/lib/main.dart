import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_management/services/services.dart';
import 'package:project_management/values/values.dart';
import 'pages/pages.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override Widget build(BuildContext context) {
//  hides both status bar and navigation buttons
//    SystemChrome.setEnabledSystemUIOverlays([]);
//  hides only status bar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: Strings.app_name,
      debugShowCheckedModeBanner: false,
      theme: Themes.lightBlueAccentRedTheme,
      darkTheme: Themes.darkBlueAccentRedTheme,
      home: SplashScreen(),
      routes: RouterService.routes,
    );
  }
}
