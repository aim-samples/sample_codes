import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management/components/components.dart';
import 'package:project_management/services/services.dart';
import 'package:project_management/values/values.dart';

class SignInPage extends StatefulWidget{ @override SignInPageState createState() => SignInPageState(); }

class SignInPageState extends State<SignInPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override Widget build(BuildContext context) => Scaffold(
    key: scaffoldKey,
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Container(
            width: constraints.maxWidth < Dimensions.max_width ? constraints.maxWidth : Dimensions.max_width,
            child: constraints.maxWidth < Dimensions.max_width ? signInUi() :
            OutlineCard(
              child: signInUi(),
              border: Border.all(color: chooseColorFromBrightness(context), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              margin: EdgeInsets.all(30),),),),),),);
  Widget signInUi() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Spacer(),
      Image(image: AssetImage(ImagesFromAssets.fuchsia), width: 100, height: 100),
      Padding(padding: EdgeInsets.only(top: 10),),
      Text(Strings.app_name,
        textAlign: TextAlign.center,
        style: CustomTextStyle.ralewayBoldWithSpace2.copyWith(
          color: chooseColorFromBrightness(context),
          fontSize: 20,),),
      Spacer(),
      Padding(
        padding: EdgeInsets.all(16),
        child: OutlineButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)),
          borderSide: BorderSide(
            color: chooseColorFromBrightness(context),
            width: 2,),
          icon: Image(image: AssetImage(ImagesFromAssets.google), width: 20, height: 20,),
          label: Text(Strings.sign_in_with_google, style: CustomTextStyle.boldWithSpace2,),
          onPressed: signIn,),),],);

  void signIn() async {
    scaffoldKey.currentState.showBottomSheet((context) => BottomSheet(
      onClosing: (){},
      builder: (context) => ListTile(
          title : Text(Strings.signing_in),
          trailing: CircularProgressIndicator(),),),);
    await GoogleAuthService().signIn().then((UserDetails currentUserDetails) async =>
      currentUserDetails != null ?
      Navigator.pushReplacementNamed(context,
          RouterService.groups_page_route,
          arguments:  RoutingArguments(userDetails: currentUserDetails)) :
      RouterService.goBack(context).then(() => scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(Strings.sign_in_failed),
        action: SnackBarAction(
          label: Strings.back,
          onPressed: RouterService.goBack(context),),),),),);
  }


}