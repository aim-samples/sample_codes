import 'dart:async';
import 'package:bluehome/components/components.dart';
import 'package:bluehome/pages/remote/field.dart';
import 'package:bluehome/pages/remote/field_query_handler.dart';
import 'package:bluehome/services/random_color_service.dart';
import 'package:bluehome/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bluehome/values/values.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class FieldsPage extends StatefulWidget{
  @override _FieldsPageState createState() => _FieldsPageState();
}

class _FieldsPageState extends State<FieldsPage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Field> fieldsList = new List();
  StreamSubscription<QuerySnapshot> querySnapshot;
  FieldQueryHandler queryHandler = new FieldQueryHandler();
  final idController            = new TextEditingController();
  final nameController          = new TextEditingController();
  final pinNoController         = new TextEditingController();
  final lastUpdatedOnController = new TextEditingController();

  @override void initState() {
    super.initState();
    querySnapshot?.cancel();
    querySnapshot = queryHandler.
    collection.
    orderBy(Keys.name, descending: false).
    snapshots().
    listen((snapshot) => setState(() => fieldsList = snapshot.
    documents.
    map((documentSnapshot) => Field.
    map(documentSnapshot.data)).
    toList(),),);
  }
  @override void dispose() {
    super.dispose();
    querySnapshot?.cancel();
  }
  @override Widget build(BuildContext context) => Scaffold(
    key: scaffoldKey,
    appBar: AppBar(
      elevation: 0,
      title: Text(Strings.remote),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => showBottomSheet(addFieldSheet()),
          tooltip: Strings.operation_create_title,),],),
    body: SafeArea(
      child: ListView.builder(
        itemCount: fieldsList.length,
        itemBuilder: (context, index) => InkWell(
          child: SwitchListTile(
            activeColor: Colors.green[500],
            inactiveThumbColor: Colors.red[500],
            secondary: Icon(Icons.lightbulb_outline, color: RandomColor.getColorFromHex(fieldsList[index].color),),
            title: Text(fieldsList[index].name),
            value: fieldsList[index].status,
            onChanged: (value) => toggleStatus(fieldsList[index]),),
          onLongPress: () => showBottomSheet(editFieldSheet(fieldsList[index]),),),),),);
  Widget addFieldSheet(){
    nameController.text = Strings.demo_field_name;
    pinNoController.text = Strings.demo_pin_no;
    lastUpdatedOnController.text = DateFormat(Strings.date_format).format(DateTime.now());
    return OperationSheet(
      titleText: Strings.create_new_field,
      children: <Widget>[
        TextInputSingleLine(
          controller: nameController,
          prefixIcon: Icons.create,
          labelText: Strings.label_name,),
        TextInputSingleLine(
          keyboardType: TextInputType.number,
          maxLength: 2,
          controller: pinNoController,
          prefixIcon: Icons.looks_one,
          labelText: Strings.label_pin_no,),
        Divider(height: 0,),
        ListTileButton(
          leadingIcon: Icons.add,
          titleText: Strings.operation_create_title,
          onTap: addField),
        Divider(height: 0,),
        ListTileButton(
          leadingIcon: Icons.cancel,
          titleText: Strings.operation_cancel_title,
          onTap: () => Navigator.of(context).pop(),),
        Divider(height: 0,),],);
  }
  Widget editFieldSheet(Field field){
    idController.text = field.id;
    nameController.text = field.name;
    pinNoController.text = field.pinNo.toString();
    lastUpdatedOnController.text = DateFormat(Strings.date_format).format(DateTime.now());
    return OperationSheet(
      titleText: Strings.edit_field,
      children: <Widget>[
        TextInputSingleLine(
          readOnly: true,
          controller: idController,
          prefixIcon: Icons.vpn_key,
          suffixIconButton: IconButton(
            icon: Icon(Icons.content_copy),
            tooltip: Strings.copy_id,
            onPressed: copyIdToClipBoard,),
          labelText: Strings.label_id,
          keyboardType: TextInputType.text,),
        TextInputSingleLine(
          controller: nameController,
          prefixIcon: Icons.create,
          labelText: Strings.label_name,),
        TextInputSingleLine(
          keyboardType: TextInputType.number,
          maxLength: 2,
          controller: pinNoController,
          prefixIcon: Icons.looks_one,
          labelText: Strings.label_pin_no,),
        Divider(height: 0,),
        ListTileButton(
          leadingIcon: Icons.update,
          titleText: Strings.operation_update_title,
          onTap: () => updateField(field),),
        Divider(height: 0,),
        ListTileButton(
          leadingIcon: Icons.delete,
          titleText: Strings.operation_delete_title,
          onTap: () => confirmDeleteField(field),),
        Divider(height: 0,),
        ListTileButton(
          leadingIcon: Icons.cancel,
          titleText: Strings.operation_cancel_title,
          onTap: () => Navigator.of(context).pop(),),
        Divider(height: 0,),],);
  }
  void copyIdToClipBoard() => Clipboard.setData(ClipboardData(text: idController.text),).then((_) =>
    showSnackBar(snackBarMessage(Strings.id_copied_message),),).then((_) => RouterService.goBack(context),);
  void addField() => queryHandler.add(field: Field(
    name: nameController.text,
    color: RandomColor.getColorInHex,
    lastUpdatedOn: lastUpdatedOnController.text,
    pinNo: int.parse(pinNoController.text),
    roomId: 'null'),).then((_) => RouterService.goBack(context));
  void confirmDeleteField(Field field) => RouterService.goBack(context).then(showDialog(
    context: context,
    builder: (context) => DeleteConfirmDialog(
      itemDetails: field,
      leadingIcon: Icons.lightbulb_outline,
      onDelete: () => deleteField(field),),),);
  void deleteField(Field field) => queryHandler.delete(id: field.id).then(RouterService.goBack(context));
  void toggleStatus(Field field) => queryHandler.toggle(field: Field(
    id: field.id,
    status: !field.status,),);
  void updateField(Field field) => queryHandler.update(field: Field(
    id: field.id,
    lastUpdatedOn: DateFormat(Strings.date_format).format(DateTime.now()),
    name: nameController.text,
    pinNo: int.parse(pinNoController.text),),).then((_) => RouterService.goBack(context),);
  void showSnackBar(SnackBar snackBar) => scaffoldKey.currentState.showSnackBar(snackBar);
  SnackBar snackBarMessage(String content) => SnackBar(content: Text(content));
  void showBottomSheet(Widget content) => scaffoldKey.currentState.showBottomSheet((context) => content);

}