import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management/services/google_auth_service.dart';
import 'package:project_management/services/router_service.dart';
import 'package:project_management/values/values.dart';
class SplashScreen extends StatefulWidget{ @override _SplashScreenState createState() => _SplashScreenState(); }

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override void initState() {
    super.initState();
    Future.delayed( Duration(seconds: 3), () async => await GoogleAuthService().currentUserDetails().then((currentUserDetails) =>
    currentUserDetails == null ?
    Navigator.pushReplacementNamed(context, RouterService.sign_in_page_route):
    Navigator.pushReplacementNamed(context, RouterService.groups_page_route, arguments: RoutingArguments(
      userDetails: currentUserDetails),),),);}
  @override Widget build(BuildContext context) => Scaffold(
    key: scaffoldKey,
    body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Image(image: AssetImage(ImagesFromAssets.fuchsia,),
            height: 100,
            width: 100,),
          Padding(padding: EdgeInsets.only(top: 10),),
          Text(Strings.app_name, style: CustomTextStyle.ralewayBoldWithSpace2.copyWith(
            color: chooseColorFromBrightness(context),
            fontSize: 20,),),
          Spacer(),
//          CircularProgressIndicator(),
//          Padding(padding: EdgeInsets.only(top: 20),),
        ],),),);
}