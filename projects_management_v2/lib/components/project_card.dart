import 'package:flutter/material.dart';
import 'package:project_management/values/values.dart';

class ProjectCard extends StatelessWidget{
  final Color               color;
  final String              trailingText;
  final IconData            leadingIcon;
  final String              titleText;
  final String              subtitleText;
  final GestureTapCallback  onTap;
  final GestureTapCallback  onLongPress;
  ProjectCard({
    this.titleText,
    this.subtitleText,
    this.trailingText,
    this.leadingIcon,
    this.color,
    this.onTap,
    this.onLongPress});
  @override Widget build(BuildContext context) => ListTile(
    leading: Container(
      padding: EdgeInsets.all(8),
      child: Icon(leadingIcon,
        color: color,),),
    title: Text(titleText,
      style: CustomTextStyle.ralewayBold,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,),
    trailing: Text(trailingText ?? '', style: CustomTextStyle.raleway),
    onTap: onTap,
    onLongPress: onLongPress,);
}