import 'package:flutter/material.dart';
// ignore: must_be_immutable
class ResponsiveGridView extends StatelessWidget {
  List<Widget>          children;
  Axis                  scrollDirection;

  ResponsiveGridView({this.children, this.scrollDirection}) {
    children        ??= null;
    scrollDirection ??= Axis.vertical;
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      scrollDirection: scrollDirection,
      child: Wrap(
          children: children,
          direction: scrollDirection == Axis.vertical ? Axis.horizontal : Axis.vertical));
}

//          children: List<Widget>.generate(projectGroups.length, (int index)=> groupCard(context, index))