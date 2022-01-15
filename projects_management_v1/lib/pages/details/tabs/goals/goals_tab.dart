import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projects_management/components/mat_components.dart';
import 'package:projects_management/pages/details/tabs/goals/goal.dart';
import 'package:projects_management/pages/details/tabs/goals/goal_query_handler.dart';
import 'package:projects_management/pages/projects/project.dart';
import 'package:projects_management/services/services.dart';
import 'package:projects_management/values/values.dart';

// ignore: must_be_immutable
class GoalsTab extends StatefulWidget{
  Project project;
  GoalsTab({this.project});
  @override GoalsTabState createState() => GoalsTabState();
}
class GoalsTabState extends State<GoalsTab> with AutomaticKeepAliveClientMixin<GoalsTab>{
  final GlobalKey<ScaffoldState>    scaffoldKey             = GlobalKey<ScaffoldState>();
  final                             nameController          = TextEditingController();
  final                             contentController       = TextEditingController();
  final                             dateController          = TextEditingController();
  final                             statusController        = TextEditingController();
  List<Goal>                        runningGoals            = new List();
  List<Goal>                        completedGoals          = new List();
  List<Goal>                        cancelledGoals          = new List();
  StreamSubscription<QuerySnapshot> runningQuerySnapshot;
  StreamSubscription<QuerySnapshot> completedQuerySnapshot;
  StreamSubscription<QuerySnapshot> cancelledQuerySnapshot;
  GoalQueryHandler                  queryHandler            = GoalQueryHandler();

  @override void initState() {
    super.initState();
    runningQuerySnapshot?.cancel();
    completedQuerySnapshot?.cancel();
    cancelledQuerySnapshot?.cancel();

    runningQuerySnapshot = queryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.running)
        .where(Keys.projectId, isEqualTo: widget.project.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    runningGoals = snapshot
        .documents
        .map((documentSnapshot) => Goal.fromMap(documentSnapshot.data)).toList()));

    completedQuerySnapshot = queryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.completed)
        .where(Keys.projectId, isEqualTo: widget.project.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    completedGoals = snapshot
        .documents
        .map((documentSnapshot) => Goal.fromMap(documentSnapshot.data)).toList()));

    cancelledQuerySnapshot = queryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.cancelled)
        .where(Keys.projectId, isEqualTo: widget.project.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    cancelledGoals = snapshot
        .documents
        .map((documentSnapshot) => Goal.fromMap(documentSnapshot.data)).toList()));
  }

  @override void dispose() {
    super.dispose();
    runningQuerySnapshot?.cancel();
    completedQuerySnapshot?.cancel();
    cancelledQuerySnapshot?.cancel();
  }

  @override bool get wantKeepAlive => true;
  // ignore: must_call_super
  @override Widget build(BuildContext context) => Scaffold(
    key: scaffoldKey,
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Container(
              width: constraints.maxWidth < 600 ? constraints.maxWidth : 600,
              child: runningGoals.length + completedGoals.length + cancelledGoals.length <= 0 ?
              Center(
                  child: Text("No goals set",
                  style: TextStyle(fontSize: constraints.maxWidth < 600 ? 16 : 30 ))) :
              ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  ListTitleCard(
                      title: 'Goals yet to be reached',
                      trailingIcon: Icons.directions_run,
                      visible: runningGoals.length <= 0 ? false : true
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: runningGoals.length,
                      itemBuilder: (_, int index) => runningCard(
                          context: context,
                          title: runningGoals[index].name,
                          subtitle: runningGoals[index].createdOn,
                          leadingIcon: Icons.assignment,
                          color: Color(int.parse(runningGoals[index].color)),
                          onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) => editGoalSheet(runningGoals[index])))),
                  ListTitleCard(
                      title: 'Completed goals',
                      trailingIcon: Icons.check,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey[800],
                      visible: completedGoals.length <= 0 ? false : true),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: completedGoals.length,
                      itemBuilder: (_, int index) => completedCard(
                          context: context,
                          title: completedGoals[index].name,
                          subtitle: completedGoals[index].createdOn,
                          leadingIcon: Icons.assignment,
                          color: Color(int.parse(completedGoals[index].color)),
                          onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) => editGoalSheet(completedGoals[index])))),
                  ListTitleCard(
                      title: 'Cancelled goals',
                      trailingIcon: Icons.cancel,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey[400],
                      visible: cancelledGoals.length <= 0 ? false : true),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: cancelledGoals.length,
                      itemBuilder: (_, int index) => cancelledCard(
                          context: context,
                          title: cancelledGoals[index].name,
                          subtitle: cancelledGoals[index].createdOn,
                          leadingIcon: Icons.assignment,
                          color: Color(int.parse(cancelledGoals[index].color)),
                          onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) => editGoalSheet(cancelledGoals[index])))),
                ],
              )
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      elevation: 5,
      tooltip: 'Set new goal',
      onPressed: () => scaffoldKey.currentState.showBottomSheet((context) => addGoalSheet()),
    ),
  );

  Widget editGoalSheet(Goal goal){
    nameController.text = goal.name;
    contentController.text = goal.content;
    dateController.text = goal.createdOn;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('Edit goal', style: TextStyle(color: Colors.white)),
            backgroundColor: Color(int.parse(goal.color)),
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: contentController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Content',
                        prefixIcon: Icon(Icons.reorder)))),
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
                  initialValue: goal.status,
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
                onTap: (){
                  queryHandler.update(Goal(
                      id        : goal.id,
                      name      : nameController.text,
                      content   : contentController.text,
                      createdOn : dateController.text,
                      color     : goal.color,
                      status    : statusController.text,
                      projectId : goal.projectId,
                      groupId   : goal.groupId));
                  Navigator.pop(context);}
            ),
            Divider(height: 0),
            ListTileButton(
                leadingIcon: Icons.delete,
                title: 'Delete',
                onTap: (){
                  queryHandler.delete(goal.id);
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

  Widget addGoalSheet(){
    nameController.text = 'goal_1';
    contentController.text = '';
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('New Goal', style: TextStyle(color: Colors.white)),
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: contentController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Content',
                        prefixIcon: Icon(Icons.reorder)))),
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
                      prefixIcon: Icon(Icons.check_box)))),
            Divider(height: 0),
            ListTileButton(
                leadingIcon: Icons.create,
                title: 'Create',
                onTap: (){
                  queryHandler.add(
                      name      : nameController.text,
                      content   : contentController.text,
                      createdOn : dateController.text,
                      color     : RandomColor.getColorHex,
                      status    : statusController.text,
                      projectId : widget.project.id,
                      groupId   : widget.project.groupId,
                      email     : widget.project.email);
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

}