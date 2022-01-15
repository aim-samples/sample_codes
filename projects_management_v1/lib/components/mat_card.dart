import 'package:flutter/material.dart';
// ignore: must_be_immutable
class MatCard extends StatelessWidget{
  Color               color;
  Widget              child;
  ShapeBorder         shape;
  double              width;
  double              height;
  EdgeInsetsGeometry  padding;
  EdgeInsetsGeometry  margin;
  GestureTapCallback  onTap;
  GestureTapCallback  onDoubleTap;
  GestureTapCallback  onLongPress;

  MatCard({
    this.color,
    this.child,
    this.shape,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress});

  @override
  Widget build(BuildContext context) => Card(
    shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
    margin: margin ?? EdgeInsets.all(5),
    elevation: 4,
    color: color,
    child: InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      customBorder: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Container(
        width: width ?? 100,
        height: height ?? 100,
        child: Padding(
          padding: padding ?? EdgeInsets.all(10),
          child: child,
        ),
      ),
    ),
  );
}

// ignore: must_be_immutable
class OutlineCard extends StatelessWidget{
  BoxBorder border;
  BorderRadiusGeometry borderRadius;
  double width;
  double height;
  Widget child;
  EdgeInsetsGeometry margin;
  EdgeInsetsGeometry padding;
  Color backgroundColor;
  OutlineCard({this.border, this.borderRadius, this.width, this.height, this.child, this.margin, this.padding, this.backgroundColor});
  @override
  Widget build(BuildContext context) => Container(
    margin: margin ?? EdgeInsets.all(0),
    padding: padding ?? EdgeInsets.all(0),
    decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
        color: backgroundColor),
    child: child,
  );
}