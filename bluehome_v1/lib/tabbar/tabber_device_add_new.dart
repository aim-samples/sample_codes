import 'package:flutter/material.dart';
import '../pages/device_add_new.dart';
import '../pages/device_configure.dart';
import '../pages/device_connect_to_wifi.dart';
// ignore: must_be_immutable
class TabBarAddDevice extends StatefulWidget{
  String title;
  TabBarAddDevice({Key key, this.title}):super(key:key);
  @override
  TabBarAddDeviceState createState() => TabBarAddDeviceState();
}
class TabBarAddDeviceState extends State<TabBarAddDevice> with SingleTickerProviderStateMixin{
  TabController tabController;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) =>
      DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: TabBar(
              controller: tabController,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.bluetooth)),
                Tab(icon: Icon(Icons.wifi)),
                Tab(icon: Icon(Icons.settings))])),
          body: TabBarView(
            controller: tabController,
            children: [
              DeviceAddNewPage(tabController: tabController,),
              DeviceConnectToWifiPage(),
              DeviceConfigurePage()])),
      );
}