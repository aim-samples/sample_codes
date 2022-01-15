import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

// ignore: must_be_immutable
class DeviceAddNewPage extends StatefulWidget{
  DeviceAddNewPage({Key key, this.title, this.tabController}) : super(key: key);
  final String title;
  TabController tabController;
  @override
  _DeviceAddNewPageState createState() => _DeviceAddNewPageState();
}

class _DeviceAddNewPageState extends State<DeviceAddNewPage> {
  BluetoothConnection bluetoothConnection;
  int counter=0;
  final nameFieldController = TextEditingController();
  final addressFieldController = TextEditingController();
  String message = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressFieldController.text = "C4:4F:33:15:4F:6B";
  }

  void dispose(){
    nameFieldController.dispose();
    addressFieldController.dispose();
    bluetoothConnection.finish();
    bluetoothConnection = null;
    super.dispose();
  }

  void checkData() => connectToBluetoothDevice(addressFieldController.text);

  Future connectToBluetoothDevice(String address) async {
    try{
      bluetoothConnection = await BluetoothConnection.toAddress(address);
      print("Connected to bluetooth device");
      bluetoothConnection.output.add(Uint8List.fromList("one".codeUnits));
      ASCII2String ascii2string = ASCII2String();
      bluetoothConnection.input.listen((Uint8List data){
        //if(ascii2string.isNewLine(data)){print(message);message = "";}
        //else{message += ascii2string.asciiVal(data);}
        if(ascii2string.readString(data)){message = ascii2string.getString();}
        print(message);
      }).onDone(() => print("Disconnected by remote request"));}
    catch(exception){print("Cannot connect, exception occurred.");}
  }
  void dataReceived(Uint8List data){
    if(ascii.decode(data) != '\n') message += ascii.decode(data);
    else print(message) ; message = "";
  }
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                    child: TextField(
                        controller: nameFieldController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            //filled: true,
                            labelText: "Device / room name",
                            helperText: "The device or room will be called with this name, ex. hall",
                            //use Icon property to move icon outside of underline
                            prefixIcon: Icon(Icons.device_hub)))),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                    child: TextField(
                        controller: addressFieldController,
                        //obscureText: false, //true for password input
                        keyboardType: TextInputType.number,
                        maxLength: 17,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          //filled: true,
                          labelText: "Bluetooth MAC Address",
                          helperText: "ex. A0:B1:C2:D3:E4:F5",
                          //use Icon property to move icon outside of underline
                          prefixIcon: Icon(Icons.bluetooth),))),
                OutlineButton(
                    child: new Text("Connect"),
                    onPressed: (){
                      connectToBluetoothDevice(addressFieldController.text);},
                    textColor: Theme.of(context).accentColor,
                    //highlightColor: Theme.of(context).accentColor,
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      style: BorderStyle.solid,
                      width: 2))])));}


class ASCII2String{
  String bufferMessage = "";
  String message = "";
  bool readString( Uint8List data){
    if (isNewLine(data)){
      message = bufferMessage;
      bufferMessage = "";
      return true;
    } else{
      bufferMessage += asciiVal(data);
      return false;
    }
  }
  String getString() => message;
  bool isNewLine(Uint8List data) => ascii.decode(data) == '\n' ? true : false;
  String asciiVal(Uint8List data) => ascii.decode(data);
}
