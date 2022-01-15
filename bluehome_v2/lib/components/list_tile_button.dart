import 'package:bluehome/values/values.dart';
import 'package:flutter/material.dart';

class ListTileButton extends StatelessWidget{
  final bool                dense;
  final IconData            leadingIcon;
  final GestureTapCallback  onTap;
  final String              titleText;
  const ListTileButton({this.dense, this.leadingIcon, this.onTap, this.titleText});
  @override Widget build(BuildContext context) => ListTile(
    dense: dense ?? false,
    leading: Icon(leadingIcon,
      color: Theme.of(context).brightness == Brightness.dark ?
      Theme.of(context).accentColor:
      Theme.of(context).primaryColor,),
    title: Text(titleText,
      style: CustomTextStyle.boldWithSpace2.copyWith(
        color: Theme.of(context).brightness == Brightness.dark ?
        Theme.of(context).accentColor:
        Theme.of(context).primaryColor,),),
    onTap: onTap,);
}