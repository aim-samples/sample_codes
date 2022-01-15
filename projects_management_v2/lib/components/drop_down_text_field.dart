import 'package:flutter/material.dart';
class DropDownTextField extends StatefulWidget{
  final TextEditingController   controller;
  final InputDecoration         decoration;
  final List<DropdownMenuItem>  items;
  DropDownTextField({ @required this.controller, @required this.items, this.decoration});
  @override DropDownTextFieldState createState() => DropDownTextFieldState();
}

class DropDownTextFieldState extends State<DropDownTextField>{
  @override Widget build(BuildContext context) => DropdownButtonFormField(
    items     : widget.items,
    onChanged : (value) => setState(() => widget.controller.text = value),
    value     : widget.controller.text ?? widget.items[0].value,
    isDense   : true,
    decoration: widget.decoration,);
}

