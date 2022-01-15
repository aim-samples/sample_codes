import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String address = "C4:4F:33:15:4F:6B"; //bluetooth address of esp32
  SharedPreferences preferences;
  String _message = "";
  int _counter = 0;
  @override
  void initState(){
    super.initState();
    initSharedPreferences();
  }
  Future initSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    // ignore: unnecessary_statements
    preferences.containsKey('counter') ? false : await preferences.setInt("counter", 0);
    setState(() => _counter = preferences.getInt('counter')??0);
  }
  void _incrementCounter() async{
    setState(() => _counter = preferences.getInt('counter')??0+1);
    await preferences.setInt('counter', _counter);
  }
  void _simpleIncrement() => setState(() => _counter++);

  Future _connectToBluetooth() async {
    try{
      BluetoothConnection connection = await BluetoothConnection.toAddress(address);
      printMessage("Connected to bluetooth device");
      connection.input.listen((Uint8List data) => connection.output.add(data)
      ).onDone(() => printMessage("Disconnected by remote request"));
    }catch(exception){
      printMessage("Cannot connect, exception occurred");
    }
  }

  void printMessage(message) => setState(() => print(_message=message));

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:',),
            Text('$_counter', style: Theme.of(context).textTheme.display1,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _simpleIncrement,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
}
