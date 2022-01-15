import 'package:flutter/material.dart';
// ignore: must_be_immutable
class DropDownTextField extends StatefulWidget{
  TextEditingController controller;
  InputDecoration decoration;
  List<DropdownMenuItem> items;
  String initialValue;
  DropDownTextField({Key key, @required this.controller, @required this.items, this.decoration, @required this.initialValue}){
    controller.text = initialValue;}
  @override
  DropDownTextFieldState createState() => DropDownTextFieldState();
}

class DropDownTextFieldState extends State<DropDownTextField>{
  @override
  Widget build(BuildContext context) => DropdownButtonFormField(
      items:  widget.items,
      onChanged: (value) => setState(() => widget.controller.text = value),
      value: widget.controller.text,
      isDense: true,
      decoration: widget.decoration
  );
}

