import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

const String service_uuid = '000000ff-0000-1000-8000-00805f9b34fb';
const String characteristic_uuid = '0000ff01-0000-1000-8000-00805f9b34fb';

class ControlPage extends StatefulWidget{
  final BluetoothDevice device;
  const ControlPage({Key key, this.device}) : super(key: key);
  @override _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override void initState() {
    widget.device.connect().then((_) =>
        widget.device.discoverServices().then((services) =>
            services.firstWhere((service) => service.uuid.toString() == service_uuid).
            characteristics.firstWhere((characteristic) => characteristic.uuid.toString() == characteristic_uuid)
            ..setNotifyValue(true)
            ..value.listen((val) => print(utf8.decode(val)))
          //read().then((val) => print(utf8.decode(val)))
        ),
    );
    super.initState();
  }
  @override void dispose() {
    super.dispose();
    widget.device.disconnect();
  }
  @override Widget build(BuildContext context) => StreamBuilder<BluetoothDeviceState>(
    stream: widget.device.state,
    builder: (_, snapshot) => FutureBuilder<List<BluetoothService>>(
      future: widget.device.discoverServices(),
      builder: (__, snapshot2) => Scaffold(
        appBar : AppBar(
          title : Text(widget.device.name,),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: ListTile(
              onTap: (){},
              title: Text(
                snapshot.hasData ?
                snapshot.data == BluetoothDeviceState.connected ? 'connected' :
                snapshot.data == BluetoothDeviceState.connecting ? 'connecting' :
                snapshot.data == BluetoothDeviceState.disconnected ? 'disconnected' :
                snapshot.data == BluetoothDeviceState.disconnecting ? 'disconnecting' :
                'failed' :
                'error',
                style: h6.copyWith(color: Colors.white),),
              trailing: Icon(
                snapshot.hasData ?
                snapshot.data == BluetoothDeviceState.connected ? Icons.check :
                snapshot.data == BluetoothDeviceState.connecting ? Icons.refresh :
                snapshot.data == BluetoothDeviceState.disconnected ? Icons.close :
                snapshot.data == BluetoothDeviceState.disconnecting ? Icons.refresh :
                Icons.warning :
                Icons.warning,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body : snapshot.hasData ?
        ListView(children : [],) :
        Icon(Icons.warning),
      )
    ),
  );
  TextStyle get h6 => Theme.of(context).textTheme.headline6;
  TextStyle get button => Theme.of(context).textTheme.button;
}
/*
*
* [        ] I/flutter (18719): 000000ff-0000-1000-8000-00805f9b34fb:::[BluetoothCharacteristic{uuid: 0000ff01-0000-1000-8000-00805f9b34fb, deviceId: 30:AE:A4:0E:14:02, serviceUuid: 000000ff-0000-1000-8000-00805f9b34fb, secondaryServiceUuid: null, properties: CharacteristicProperties{broadcast: false, read: true, writeWithoutResponse: false, write: true, notify: true, indicate: false, authenticatedSignedWrites: false, extendedProperties: false, notifyEncryptionRequired: false, indicateEncryptionRequired: false}, descriptors: [BluetoothDescriptor{uuid: 00002902-0000-1000-8000-00805f9b34fb, deviceId: 30:AE:A4:0E:14:02, serviceUuid: 000000ff-0000-1000-8000-00805f9b34fb, characteristicUuid: 0000ff01-0000-1000-8000-00805f9b34fb, value: []}], value: []]
* */