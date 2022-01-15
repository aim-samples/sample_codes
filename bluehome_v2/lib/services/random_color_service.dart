import 'dart:math';
import 'package:flutter/material.dart';
class RandomColor{
  static List colorsTray800  = [
    Colors.red[800]       ,
    Colors.pink[800]      ,
    Colors.purple[800]    ,
    Colors.deepPurple[800],
    Colors.indigo[800]    ,
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
    Colors.blueGrey[800],];

  static List colorsTray500  = [
    Colors.red[500]       ,
    Colors.pink[500]      ,
    Colors.purple[500]    ,
    Colors.deepPurple[500],
    Colors.indigo[500]    ,
    Colors.blue[500]      ,
    Colors.lightBlue[500] ,
    Colors.cyan[500]      ,
    Colors.teal[500]      ,
    Colors.green[500]     ,
    Colors.lightGreen[500],
    Colors.lime[500]      ,
    Colors.yellow[500]    ,
    Colors.amber[500]     ,
    Colors.orange[500]    ,
    Colors.deepOrange[500],
    Colors.brown[500]     ,
    Colors.grey[500]      ,
    Colors.blueGrey[500],];

  static Color  get getColor                      => colorsTray500[Random().nextInt(colorsTray500.length-1)];
  static String get getColorInHex                 => '0x' + getColor.value.toRadixString(16);
  static String     getHexFromColor(Color color)  => '0x' + color.value.toRadixString(16);
  static Color getColorFromHex(String colorInHex) => Color(int.parse(colorInHex));
}