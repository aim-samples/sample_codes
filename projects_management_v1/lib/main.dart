import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projects_management/pages/pages.dart';
import 'package:projects_management/services/services.dart';
import 'package:projects_management/values/values.dart';
void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.android;
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override Widget build(BuildContext context) => MaterialApp(
    title: Strings.app_name,
    home: FutureBuilder(
        future: GoogleAuthService().currentUser,
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) =>
        snapshot.hasData ? ProjectGroupsPage() : SignInPage()),
    routes: RouterService.routes,
    theme: Themes.lightBlueTheme);
}
