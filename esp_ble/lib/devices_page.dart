
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_boost/let.dart';
import 'control_page.dart';
class DevicesPage extends StatefulWidget {
  DevicesPage({Key key}) : super(key: key);
  @override _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Devices'),
    ),
    body: StreamBuilder(
      stream: flutterBlue.scanResults,
      builder: (context, snapshot) => snapshot.hasData ? Let<List<ScanResult>>(
        let: snapshot.data,
        builder: (results) => ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) => Let<BluetoothDevice>(
            let: results[index].device,
            builder: (device) => ListTile(
              leading: Icon(Icons.bluetooth),
              title: Text(device.name),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ControlPage(device : device)))
                  // device.connect().then((_) =>
                  //     device.discoverServices().then((services) =>
                  //         services.forEach((service) =>
                  //             print('${service.uuid}:::${service.characteristics}'),
                  //         ),
                  //     ),
                  // ),
            ),
          ),
        ),
      ) : Icon(Icons.warning),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () =>
      flutterBlue
        ..startScan(timeout: Duration(seconds: 4))
        ..stopScan(),
      tooltip: 'Scan',
      child: Icon(Icons.refresh),
    ),
  );
}