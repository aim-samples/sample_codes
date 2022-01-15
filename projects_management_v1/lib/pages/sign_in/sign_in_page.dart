import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects_management/components/mat_card.dart';
import 'package:projects_management/values/values.dart';
import 'package:projects_management/services/services.dart';

class SignInPage extends StatefulWidget{
  @override SignInPageState createState()=> SignInPageState();
}
class SignInPageState extends State<SignInPage>{
  @override Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: Container(
              width: constraints.maxWidth < 600 ? constraints.maxWidth : 600,
              child: constraints.maxWidth < 600 ? signInUi() : OutlineCard(
                child: signInUi(),
                border: Border.all(color: Theme.of(context).accentColor, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                margin: EdgeInsets.all(30),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget signInUi() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Spacer(flex: 1),
      Image(image: AssetImage(Images.fuchsia_logo), width: 200, height: 200),
      Center(
        child: Text(
          Strings.app_name,
          style: Theme.of(context).textTheme.title.copyWith(color: Theme.of(context).accentColor),
        ),
      ),
      Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Sign in',
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      ),
      Spacer(flex: 4),
      Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
        child: OutlineButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          borderSide: BorderSide(
              color: Colors.green[800],
              width: 2
          ),
          icon: Image(image: AssetImage(Images.google_logo), width: 20, height: 20,),
          label: Text('Sign in with google'),
          onPressed: (){
            GoogleAuthService().signIn().whenComplete(() =>
                Navigator.pushReplacementNamed(context, RouterService.project_groups_page_route)
//              Navigator.pushNamedAndRemoveUntil(context, RouterService.project_groups_page_route, (r) => false)
//                Navigator.pop(context)
            );
          },
        ),
      ),
      Spacer(flex: 1),
    ],
  );
}