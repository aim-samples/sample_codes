import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_management/components/components.dart';
import 'package:project_management/services/services.dart';
import 'package:project_management/values/values.dart';
import 'group.dart';
import 'group_query_handler.dart';

class GroupPage extends StatefulWidget {
  @override _GroupPageState createState() => _GroupPageState();}

class _GroupPageState extends State<GroupPage> {
  GlobalKey<ScaffoldState>          scaffoldKey                 = GlobalKey<ScaffoldState>();
  final                             nameController              = new TextEditingController();
  final                             createdOnController         = new TextEditingController();
  List<Group>                       groups                      = new List();
  StreamSubscription<QuerySnapshot> querySnapshot;
  GroupQueryHandler                 queryHandler                = new GroupQueryHandler();
  UserDetails                       userDetails;
  @override void initState() {
    super.initState();
    querySnapshot?.cancel();
  }
  @override void dispose() {
    super.dispose();
    querySnapshot?.cancel();
  }
  void init() {
//    userDetails = await GoogleAuthService().currentUserDetails();
    userDetails = (ModalRoute
        .of(context)
        .settings
        .arguments as RoutingArguments).userDetails;
    querySnapshot = queryHandler
        .collection
        .where(Keys.email, isEqualTo: userDetails.userEmail)
        .orderBy(Keys.name, descending: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) =>
        setState(() => groups = snapshot.documents.map((documentSnapshot) =>
            Group.map(documentSnapshot.data)).toList()));
  }
  @override Widget build(BuildContext context) {
    init();
    return mainScaffold(
      context: context,
      key: scaffoldKey,
      titleText: Strings.app_name,
      userDetails: userDetails,
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Container(
            width: constraints.maxWidth < Dimensions.max_width ? constraints.maxWidth : Dimensions.max_width,
            child: groups.length <= 0 ? NoDataFoundUI() : groupsListView(),),),),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(ConstantIcons.create),
        label: Text(Strings.operation_create_title,
          style: CustomTextStyle.firaCodeBold,),
        tooltip: Strings.create_new_group,
        onPressed: () => scaffoldKey.currentState.showBottomSheet((context) => addGroupSheet(),),) ,
    );
  }
  Widget groupsListView() => ListView.builder(
    physics: ClampingScrollPhysics(),
    itemCount: groups.length,
    itemBuilder: (context,index) => ProjectCard(
      color: RandomColor.getColorFromHex(groups[index].color),
      leadingIcon: ConstantIcons.group,
      titleText: groups[index].name,
      trailingText: groups[index].createdOn,
      onTap: () => Navigator.pushNamed(
        context,
        RouterService.projects_page_route,
        arguments: RoutingArguments(content: groups[index].toMap, userDetails: userDetails,),),
      onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) => editGroupSheet(groups[index],),),),
    );
  Widget addGroupSheet(){
    nameController.text = Strings.new_group;
    createdOnController.text = DateFormat(Strings.date_format).format(DateTime.now());
    return OperationSheet(
      titleText: Strings.create_new_group,
      children: <Widget>[
        TextInput(
            controller: nameController,
            prefixIcon: ConstantIcons.name,
            labelText: Strings.label_name),
        TextInput(
          controller: createdOnController,
          prefixIcon: ConstantIcons.created_on,
          labelText: Strings.label_created_on,),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.create,
          titleText: Strings.operation_create_title,
          onTap: addGroup,),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.cancel,
          titleText: Strings.operation_cancel_title,
          onTap: () => RouterService.goBack(context),),
        Divider(height: 0),],
    );
  }
  Widget editGroupSheet(Group group){
    nameController.text = group.name;
    createdOnController.text = group.createdOn;
    return OperationSheet(
      titleText: Strings.edit_group,
      children: <Widget>[
        TextInput(
          controller: nameController,
          prefixIcon: ConstantIcons.name,
          labelText: Strings.label_name,),
        TextInput(
          controller: createdOnController,
          prefixIcon: ConstantIcons.created_on,
          labelText: Strings.label_created_on,),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.update,
          titleText: Strings.operation_update_title,
          onTap: () => updateGroup(group),),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.delete,
          titleText: Strings.operation_delete_title,
          onTap: () => confirmDeleteGroup(group),),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.cancel,
          titleText: Strings.operation_cancel_title,
          onTap: () => RouterService.goBack(context),),
        Divider(height: 0),],
    );
  }

  void addGroup() async {
    showSnackBar(Strings.creating_group);
    queryHandler.add(group: Group(
      name: nameController.text,
      createdOn: createdOnController.text,
      color: RandomColor.getColorInHex,
      email: userDetails.userEmail,),).then((result) => RouterService.goBack(context));
  }
  void confirmDeleteGroup(Group group) => RouterService.goBack(context).then(showDialog(
    context: context, builder: (builder) => DeleteConfirmDialog(
    itemDetails: group,
    leadingIcon: ConstantIcons.group,
    onDelete: () => deleteGroup(group.id),),),);
  void deleteGroup(id) async {
    showSnackBar(Strings.deleting_group);
    queryHandler.delete(id).then((result) => RouterService.goBack(context),);
  }
  void updateGroup(group) async {
    showSnackBar(Strings.updating);
    queryHandler.update(Group(
      id: group.id,
      name: nameController.text,
      createdOn: createdOnController.text,
      color: group.color,),).then((result) => RouterService.goBack(context),);
  }
  void showSnackBar(String message) => scaffoldKey.currentState.showSnackBar(
    SnackBar(content: Text(message,), duration: Duration(seconds: 1),),);
}