import 'package:bluehome/MyHomePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChooseDevice extends StatefulWidget{
  ChooseDevice({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ChooseDevice createState() => _ChooseDevice();
}

class _ChooseDevice extends State<ChooseDevice>{
  String _title = "";
  void isWeb() => setState(() => _title = kIsWeb ? "web":"other");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isWeb();
  }
  int boolToInt1(success) => success ? 1 : 0;
  bool intToBool(success) => success == 1 ? true : false;
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new OutlineButton(
                textColor: Colors.blue,
                child: Text(_title),
                borderSide: BorderSide(
                    color: Colors.blue,
                    style: BorderStyle.solid,
                    width: 1),
                onPressed: () {},
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(title: "wonder",)));
          },
          tooltip: 'Add new device',
          child: Icon(Icons.add),
        ),
        drawer: Drawer(),
      );

}