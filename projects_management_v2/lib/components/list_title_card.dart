import 'package:flutter/material.dart';
import 'package:project_management/values/values.dart';

class ListTitleCard extends StatelessWidget{
  final IconData trailingIcon;
  final String title;
  final bool visible;
  final Color backgroundColor;
  final Color foregroundColor;
  ListTitleCard({
    this.trailingIcon,
    this.title,
    this.visible,
    this.backgroundColor,
    this.foregroundColor});
  @override Widget build(BuildContext context) => Visibility(
    child: Card(
      elevation: 0,
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.all(0),
      child: ListTile(
        dense: true,
        trailing: Icon(trailingIcon, color: foregroundColor ?? Theme.of(context).textTheme.title.color),
        title: Text(title, style: CustomTextStyle.ralewayBoldWithSpace2,),),),
    visible: visible ?? true,);
}