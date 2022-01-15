import 'package:flutter/material.dart';
class OperationSheet extends StatelessWidget{
  final List<Widget> children;
  final String titleText;
  const OperationSheet({this.children, this.titleText});
  @override Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,  // necessary as text field gets hidden in bottom sheet
    appBar: AppBar(
      elevation: 0,
      leading: Container(),
      title: Text(titleText),
      centerTitle: true,),
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: children,),);
}