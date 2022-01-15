import 'dart:io';

import 'package:bluehome/pages/device_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
void main() {
  //debugDefaultTargetPlatformOverride =  selectPlatform();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        accentColor: Colors.red[300]),
      home: DeviceSelectPage(title: "Select Device"));
}

selectPlatform()=>
    Platform.isWindows  ? TargetPlatform.android  :
    Platform.isLinux    ? TargetPlatform.android  :
    Platform.isMacOS    ? TargetPlatform.iOS      :
    Platform.isAndroid  ? TargetPlatform.android  :
    Platform.isIOS      ? TargetPlatform.iOS      :
    Platform.isFuchsia  ? TargetPlatform.fuchsia  :
                          TargetPlatform.android  ; //nested if else