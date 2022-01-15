import 'package:flutter/material.dart';
import 'choose_device.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.green[800]),
    home: ChooseDevice(title: 'Choose Device'));
}