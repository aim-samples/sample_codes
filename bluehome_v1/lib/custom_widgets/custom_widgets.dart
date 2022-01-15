import 'dart:ui';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class HorizontalDivider extends StatelessWidget{
  Color color;
  double width;
  double padding;
  HorizontalDivider({Key key, this.color, this.width, this.padding}){
    color   ??= Colors.black; //color   = if(color == null)   Colors.black  else color;
    width   ??= 1.0;          //width   = if(width == null)   0             else width;
    padding ??= 0;            //padding = if(padding == null) 0             else padding;
  }
  @override
  Widget build(BuildContext context) => Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: color, width: width))));}