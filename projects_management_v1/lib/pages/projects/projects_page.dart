import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projects_management/components/mat_components.dart';
import 'package:projects_management/pages/group/project_group.dart';
import 'package:projects_management/pages/projects/project.dart';
import 'package:projects_management/pages/projects/projects_query_handler.dart';
import 'package:projects_management/services/random_color_service.dart';
import 'package:projects_management/services/services.dart';
import 'package:projects_management/values/values.dart';

class ProjectsPage extends StatefulWidget{@override ProjectsPageState createState() => ProjectsPageState();}
class ProjectsPageState extends State<ProjectsPage>{
  GlobalKey<ScaffoldState>          scaffoldKey         = GlobalKey<ScaffoldState>();
  final                             nameController      = TextEditingController();
  final                             dateController      = TextEditingController();
  final                             statusController    = TextEditingController();
  ProjectGroup                      routingArguments;
  List<Project>                     runningProjects     = new List();
  List<Project>                     completedProjects   = new List();
  List<Project>                     cancelledProjects   = new List();
  StreamSubscription<QuerySnapshot> runningQuerySnapshot;
  StreamSubscription<QuerySnapshot> completedQuerySnapshot;
  StreamSubscription<QuerySnapshot> cancelledQuerySnapshot;
  ProjectQueryHandler               queryHandler        = ProjectQueryHandler();

  @override void initState() {
    super.initState();
    runningQuerySnapshot?.cancel();
    completedQuerySnapshot?.cancel();
    cancelledQuerySnapshot?.cancel();
  }
  @override void dispose() {
    super.dispose();
    runningQuerySnapshot?.cancel();
    completedQuerySnapshot?.cancel();
    cancelledQuerySnapshot?.cancel();
  }
  void init(BuildContext context){
    routingArguments = ProjectGroup.fromMap((ModalRoute
        .of(context)
        .settings
        .arguments as RoutingArguments).map);

    runningQuerySnapshot = queryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.running)
        .where(Keys.groupId, isEqualTo: routingArguments.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    runningProjects = snapshot
        .documents
        .map((documentSnapshot) => Project.fromMap(documentSnapshot.data)).toList()));

    completedQuerySnapshot = queryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.completed)
        .where(Keys.groupId, isEqualTo: routingArguments.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    completedProjects = snapshot
        .documents
        .map((documentSnapshot) => Project.fromMap(documentSnapshot.data)).toList()));

    cancelledQuerySnapshot = queryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.cancelled)
        .where(Keys.groupId, isEqualTo: routingArguments.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    cancelledProjects = snapshot
        .documents
        .map((documentSnapshot) => Project.fromMap(documentSnapshot.data)).toList()));
  }

  @override Widget build(BuildContext context) {
    init(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(routingArguments.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
            builder: (context, constraints) => Center(
                child: Container(
                    width: constraints.maxWidth < 600 ? constraints.maxWidth : 600,
                    child: runningProjects.length + completedProjects.length + cancelledProjects.length <= 0 ?
                    Center(
                        child: Text("Projects not found, try creating one",
                        style: TextStyle(fontSize: constraints.maxWidth < 600 ? 16 : 30 ))) :
                    ListView(
                      physics: ClampingScrollPhysics(),
                      children: <Widget>[
                        ListTitleCard(
                          title: 'Live projects',
                          trailingIcon: Icons.directions_run,
                          visible: runningProjects.length <= 0 ? false : true),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: runningProjects.length,
                            itemBuilder: (_, int index) => runningCard(
                                context: context,
                                title: runningProjects[index].name,
                                subtitle: runningProjects[index].createdOn,
                                leadingIcon: Icons.assignment,
                                color: Color(int.parse(runningProjects[index].color)),
                                onTap: () => Navigator.pushNamed(
                                    context,
                                    RouterService.project_details_page_route,
                                    arguments: RoutingArguments(map: runningProjects[index].toMap)
                                ),
                                onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) => editProjectSheet(runningProjects[index])))),
                        ListTitleCard(
                            title: 'Completed project',
                            trailingIcon: Icons.check,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.grey[800],
                            visible: completedProjects.length <= 0 ? false : true),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: completedProjects.length,
                            itemBuilder: (_, int index) => completedCard(
                                context: context,
                                title: completedProjects[index].name,
                                subtitle: completedProjects[index].createdOn,
                                leadingIcon: Icons.assignment,
                                color: Color(int.parse(completedProjects[index].color)),
                                onTap: () => Navigator.pushNamed(
                                    context,
                                    RouterService.project_details_page_route,
                                    arguments: RoutingArguments(map: completedProjects[index].toMap)),
                                onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) => editProjectSheet(completedProjects[index])))),
                        ListTitleCard(
                            title: 'Cancelled projects',
                            trailingIcon: Icons.cancel,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.grey[400],
                            visible: cancelledProjects.length <= 0 ? false : true),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: cancelledProjects.length,
                            itemBuilder: (_, int index) => cancelledCard(
                                context: context,
                                title: cancelledProjects[index].name,
                                subtitle: cancelledProjects[index].createdOn,
                                leadingIcon: Icons.assignment,
                                color: Color(int.parse(cancelledProjects[index].color)),
                                onTap: () => Navigator.pushNamed(
                                    context,
                                    RouterService.project_details_page_route,
                                    arguments: RoutingArguments(map: cancelledProjects[index].toMap)),
                                onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) => editProjectSheet(cancelledProjects[index])))),
                      ],
                    )
                )))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 5,
        tooltip: 'Create new project',
        onPressed: () => scaffoldKey.currentState.showBottomSheet((context) => addProjectSheet()),
      ),
    );
  }


  Widget editProjectSheet(Project project){
    nameController.text = project.name;
    dateController.text = project.createdOn;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('Edit project', style: TextStyle(color: Colors.white)),
            backgroundColor: Color(int.parse(project.color)),
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_downward, color: Colors.white),
                onPressed: () => Navigator.pop(context))),
        body: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Project name',
                        prefixIcon: Icon(Icons.create)))),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Created on',
                        prefixIcon: Icon(Icons.access_time)))),
            Padding(
                padding: EdgeInsets.all(10),
                child: DropDownTextField(
                  initialValue: project.status,
                  controller: statusController,
                  items: [Status.running, Status.completed, Status.cancelled]
                      .map((value) => DropdownMenuItem( child: Text(value), value: value ))
                      .toList(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Current status',
                      prefixIcon: Icon(Icons.check_box)))),
            Divider(height: 0),
            ListTileButton(
                leadingIcon: Icons.update,
                title: 'Update',
                onTap: (){ queryHandler.update(Project(
                    id        : project.id,
                    name      : nameController.text,
                    createdOn : dateController.text,
                    status    : statusController.text,
                    color     : project.color,
                    groupId   : project.groupId));
                Navigator.pop(context);}),
            Divider(height: 0),
            ListTileButton(
                leadingIcon: Icons.delete,
                title: 'Delete',
                onTap: (){
                  queryHandler.delete(project.id);
                  Navigator.pop(context);}),
            Divider(height: 0),
            ListTileButton(
                leadingIcon: Icons.cancel,
                title: 'Cancel',
                onTap: () => Navigator.pop(context)),
            Divider(height: 0),
          ],
        )
    );
  }

  Widget addProjectSheet(){
    nameController.text = 'project_1';
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('New project', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.blue[800],
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_downward, color: Colors.white),
                onPressed: () => Navigator.pop(context))),
        body: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.create)))),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Created on',
                        prefixIcon: Icon(Icons.access_time)))),
            Padding(
                padding: EdgeInsets.all(10),
                child: DropDownTextField(
                  initialValue: Status.running,
                  controller: statusController,
                  items: [Status.running, Status.completed, Status.cancelled]
                      .map((value) => DropdownMenuItem( child: Text(value), value: value ))
                      .toList(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Current status',
                      prefixIcon: Icon(Icons.check_box)),
                )),
            Divider(height: 0),
            ListTileButton(
              leadingIcon: Icons.add,
              title: 'Create',
              onTap: (){
                queryHandler.add(
                    name      : nameController.text,
                    createdOn : dateController.text,
                    status    : statusController.text,
                    color     : RandomColor.getColorHex,
                    groupId   : routingArguments.id,
                    email     : routingArguments.email);
                Navigator.pop(context);},
            ),
            Divider(height: 0),
            ListTileButton(
              leadingIcon: Icons.cancel,
              title: 'Cancel',
              onTap: () => Navigator.pop(context),
            ),
            Divider(height: 0),
          ],
        )
    );
  }
}