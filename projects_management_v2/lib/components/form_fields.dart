import 'package:flutter/material.dart';
import 'package:project_management/components/components.dart';
import 'package:project_management/values/values.dart';

class TextInput extends StatelessWidget{
  final TextEditingController controller;
  final IconData prefixIcon;
  final String labelText;
  final EdgeInsetsGeometry padding;
  TextInput({this.controller, this.prefixIcon, this.labelText, this.padding});
  @override Widget build(BuildContext context) => Padding(
    padding: padding ?? const EdgeInsets.all(10),
    child: TextField(
      controller: controller,
      style: CustomTextStyle.boldWithSpace2,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(),
        labelText: labelText,
        labelStyle: CustomTextStyle.boldWithSpace2,),),);
}

class TextInputMultiLine extends StatelessWidget{
  final TextEditingController controller;
  final IconData prefixIcon;
  final String labelText;
  final EdgeInsetsGeometry padding;
  TextInputMultiLine({this.controller, this.prefixIcon, this.labelText, this.padding});
  @override Widget build(BuildContext context) => Padding(
    padding: padding ?? const EdgeInsets.all(10),
    child: TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: controller,
      style: CustomTextStyle.boldWithSpace2,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(),
        labelText: labelText,
        labelStyle: CustomTextStyle.boldWithSpace2,),),
  );
}

class TextInputSelect extends StatelessWidget{
  final TextEditingController controller;
  final IconData prefixIcon;
  final String labelText;
  final EdgeInsetsGeometry padding;
  final List<String> items;
  TextInputSelect({this.controller, this.prefixIcon, this.labelText, this.padding, this.items});
  @override Widget build(BuildContext context) => Padding(
    padding: padding ?? const EdgeInsets.all(10),
    child: DropDownTextField( 	
      controller: controller,
      items: items.map((value) => DropdownMenuItem(
          child: Text(value, style: CustomTextStyle.boldWithSpace2), value: value )).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        labelStyle: CustomTextStyle.boldWithSpace2,
        prefixIcon: Icon(prefixIcon,),),),
  );
}
