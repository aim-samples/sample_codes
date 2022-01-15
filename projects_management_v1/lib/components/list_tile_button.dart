import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListTileButton extends StatelessWidget {
  IconData leadingIcon;
  String title;
  GestureTapCallback onTap;
  ListTileButton({this.onTap, this.leadingIcon, this.title});
  @override Widget build(BuildContext context) => ListTile(
      leading: Icon(leadingIcon),
      title: Text(title, style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey[700],
          fontWeight: FontWeight.bold)),
      onTap: onTap);
}