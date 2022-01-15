import 'package:bluehome/components/components.dart';
import 'package:bluehome/values/values.dart';
import 'package:flutter/material.dart';

class TextInputSingleLine extends StatelessWidget{
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final int maxLength;
  final EdgeInsetsGeometry padding;
  final IconData prefixIcon;
  final bool readOnly;
  final Widget suffixIconButton;
  TextInputSingleLine({this.controller, this.keyboardType, this.prefixIcon, this.labelText, this.maxLength, this.padding, this.readOnly, this.suffixIconButton});
  @override Widget build(BuildContext context) => Padding(
    padding: padding ?? const EdgeInsets.all(10),
    child: TextField(
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      keyboardType: keyboardType,
      controller: controller,
      style: CustomTextStyle.boldWithSpace2,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIconButton,
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

// ignore: must_be_immutable
class SwitchTile extends StatefulWidget{
  IconData leadingIcon;
  bool status;
  String titleText;
  SwitchTile({this.leadingIcon, this.status, this.titleText});
  @override _SwitchTileState createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  @override Widget build(BuildContext context) => SwitchListTile(
    secondary: Icon(widget.leadingIcon),
    title: Text(widget.titleText),
    value: widget.status,
    onChanged: (value) => setState(() => widget.status = !widget.status),);
}