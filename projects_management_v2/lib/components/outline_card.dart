import 'package:flutter/material.dart';

class OutlineCard extends StatelessWidget{
  final BoxBorder border;
  final BorderRadiusGeometry borderRadius;
  final double width;
  final double height;
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  OutlineCard({
    this.border,
    this.borderRadius,
    this.width,
    this.height,
    this.child,
    this.margin,
    this.padding,
    this.backgroundColor});
  @override Widget build(BuildContext context) => Container(
    margin: margin ?? EdgeInsets.all(0),
    padding: padding ?? EdgeInsets.all(0),
    decoration: BoxDecoration(
      border: border,
      borderRadius: borderRadius,
      color: backgroundColor,),
    child: child,);
}