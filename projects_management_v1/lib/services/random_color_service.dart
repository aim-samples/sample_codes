import 'dart:math';
import 'package:flutter/material.dart';
class RandomColor{
  static List colorsTray  = [
    Colors.red[500]       ,
    Colors.pink[500]      ,
    Colors.purple[800]    ,
    Colors.deepPurple[800],
    Colors.indigo[500]    ,
    Colors.blue[800]      ,
    Colors.lightBlue[800] ,
    Colors.cyan[800]      ,
    Colors.teal[800]      ,
    Colors.green[800]     ,
    Colors.lightGreen[800],
    Colors.lime[800]      ,
    Colors.yellow[800]    ,
    Colors.amber[800]     ,
    Colors.orange[800]    ,
    Colors.deepOrange[800],
    Colors.brown[800]     ,
    Colors.grey[800]      ,
    Colors.blueGrey[800]] ;
  static Color  get getColor                      => colorsTray[Random().nextInt(colorsTray.length-1)];
  static String get getColorHex                   => '0x' + getColor.value.toRadixString(16);
  static String     getHexFromColor(Color color)  => '0x' + color.value.toRadixString(16);
}