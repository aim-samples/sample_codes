import 'package:flutter/material.dart';

class DeviceConfigurePage extends StatefulWidget{
  DeviceConfigurePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() => _DeviceConfigurePageState();
}
class _DeviceConfigurePageState extends State<DeviceConfigurePage>{
  @override
  Widget build(BuildContext context) => Scaffold(
    body: ButtonBar(
      children: <Widget>[
        FlatButton(
          onPressed: (){},
          child: Text("darkRed"),
        )
      ],
    ),
  );
}
