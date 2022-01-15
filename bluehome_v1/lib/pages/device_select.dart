import 'package:bluehome/tabbar/tabber_device_add_new.dart';
import 'package:flutter/material.dart';

class DeviceSelectPage extends StatefulWidget {
  DeviceSelectPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DeviceSelectPageState createState() => _DeviceSelectPageState();
}
class _DeviceSelectPageState extends State<DeviceSelectPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('You have pushed the button this many times:'),
                Text('_counter', style: Theme.of(context).textTheme.display1)])),
          floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TabBarAddDevice(title: "Add new device"))),
              tooltip: 'Add new device',
              child: Icon(Icons.add)));}
