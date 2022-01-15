import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProjectCard extends StatelessWidget{
  Widget title;
  Widget subtitle;
  Widget leading;
  Widget trailing;
  Color color;
  double elevation;
  bool isThreeLine;
  GestureTapCallback onTap;
  GestureTapCallback onLongPress;
  ProjectCard({
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.color,
    this.elevation,
    this.isThreeLine = false,
    this.onTap,
    this.onLongPress}):assert(isThreeLine != null);
  @override
  Widget build(BuildContext context) => Card(
      elevation: elevation,
      color: color,
      child: ListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        onLongPress: onLongPress,
        isThreeLine: isThreeLine,
      )
  );
}
Widget runningCard({
  BuildContext context,
  String title,
  String subtitle,
  IconData leadingIcon,
  Color color,
  GestureTapCallback onTap,
  GestureTapCallback onLongPress}) => ProjectCard(
    title: Text(title),
    subtitle: Text(subtitle),
    leading: Padding(
      padding: EdgeInsets.all(10),
      child: Icon(
        leadingIcon, color: Theme.of(context).brightness == Brightness.dark ? null : color)),
    color: Theme.of(context).brightness == Brightness.dark ? color : null,
    onTap: onTap,
    onLongPress:  onLongPress);

Widget completedCard({
  BuildContext context,
  String title,
  String subtitle,
  IconData leadingIcon,
  Color color,
  GestureTapCallback onTap,
  GestureTapCallback onLongPress}) => ProjectCard(
    title: Text(
        title,
        style: TextStyle(
            color: Colors.white,)),
    subtitle: Text(
        subtitle,
        style: TextStyle(
            color: Colors.white,)),
    leading: Padding(
      padding: EdgeInsets.all(10),
      child: Icon(
          leadingIcon,
          color: Colors.white)),
    color: Colors.grey[800],
    elevation: 0,
    onTap: onTap,
    onLongPress:  onLongPress);

Widget cancelledCard({
  BuildContext context,
  String title,
  String subtitle,
  IconData leadingIcon,
  Color color,
  GestureTapCallback onTap,
  GestureTapCallback onLongPress}) => ProjectCard(
    title: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.lineThrough)),
    subtitle: Text(
        subtitle,
        style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.lineThrough)),
    leading: Padding(
      padding: EdgeInsets.all(10),
      child: Icon(leadingIcon, color: Colors.white)),
    color: Colors.grey[500],
    elevation: 0,
    onTap: onTap,
    onLongPress: onLongPress);

// ignore: must_be_immutable
class ListTitleCard extends StatelessWidget{
  IconData trailingIcon;
  String title;
  bool visible;
  Color backgroundColor;
  Color foregroundColor;
  ListTitleCard({
    this.trailingIcon,
    this.title,
    this.visible,
    this.backgroundColor,
    this.foregroundColor});
  @override Widget build(BuildContext context) => Visibility(
    child: Card(
      child: ListTile(
          dense: true,
          trailing: Icon(trailingIcon, color: foregroundColor ?? Theme.of(context).textTheme.title.color),
          title: Text(title, style: TextStyle(color: foregroundColor ?? Theme.of(context).textTheme.title.color))),
      elevation: 0,
      color: backgroundColor ?? Theme.of(context).cardColor),
    visible: visible,
  );

}