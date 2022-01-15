import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projects_management/components/mat_components.dart';
import './project_group.dart';
import './project_group_query_handler.dart';
import 'package:projects_management/services/services.dart';
import 'package:projects_management/values/values.dart';
class ProjectGroupsPage extends StatefulWidget{
  @override ProjectGroupsPageState createState() => ProjectGroupsPageState();
}

class ProjectGroupsPageState extends State<ProjectGroupsPage>{
  GlobalKey<ScaffoldState>          scaffoldKey         = GlobalKey<ScaffoldState>();
  final                             nameController      = TextEditingController();
  final                             dateController      = TextEditingController();
  List<ProjectGroup>                groups              = new List();
  StreamSubscription<QuerySnapshot> querySnapshot;
  ProjectGroupQueryHandler          queryHandler        = new ProjectGroupQueryHandler();
  UserDetails                       userDetails         = new UserDetails();
  @override void initState() {
    super.initState();
    querySnapshot?.cancel();}

  @override void dispose() {
    super.dispose();
    querySnapshot?.cancel();}

  void init() async {
    userDetails = await GoogleAuthService().currentUserDetails();
    querySnapshot = queryHandler
        .collection
        .where(Keys.email, isEqualTo: userDetails.userEmail)
        .snapshots()
        .listen((QuerySnapshot snapshot) =>
        setState(() =>
        groups = snapshot.documents.map((documentSnapshot) =>
            ProjectGroup.map(documentSnapshot.data)).toList()));}

  @override Widget build(BuildContext context) {
    init();
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            title: Text(Strings.app_name),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) =>
                          accountDialog(userDetails.userName, userDetails.userEmail, userDetails.userImageUrl)))
            ]),
        body: SafeArea(
            child: LayoutBuilder(
                builder: (context, constraints) => Center(
                    child: Container(
                        width: constraints.maxWidth < 600 ? constraints.maxWidth : 600,
                        child: groups.length <= 0 ?
                        Center(child: Text("Project groups not found, try creating one",
                            style: TextStyle(fontSize: constraints.maxWidth < 600 ? 16 : 30 ))) :
                        ListView.builder(
                            itemCount: groups.length,
                            itemBuilder: (_, int index) => runningCard(
                                context: context,
                                title: groups[index].name,
                                subtitle: groups[index].createdOn,
                                leadingIcon: Icons.folder,
                                color: Color(int.parse(groups[index].color)),
                                onTap: () => Navigator.pushNamed(
                                    context,
                                    RouterService.projects_page_route,
                                    arguments: RoutingArguments(map: groups[index].toMap)),
                                onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) =>
                                    editGroupSheet(groups[index])))))))),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 5,
          tooltip: 'Create new project group',
          onPressed: () => scaffoldKey.currentState.showBottomSheet((context) => addGroupSheet()),
        )
    );
  }

  Widget editGroupSheet(ProjectGroup group){
    nameController.text   = group.name;
    dateController.text   = group.createdOn;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('Edit project group', style: TextStyle(color: Colors.white)),
            backgroundColor: Color(int.parse(group.color)),
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
            Divider(height: 0),
            ListTileButton(
                leadingIcon: Icons.update,
                title: 'Update',
                onTap: () {
                  queryHandler.update(ProjectGroup(
                      id        : group.id,
                      name      : nameController.text,
                      createdOn : dateController.text,
                      color     : group.color));
                  Navigator.pop(context);}),
            Divider(height: 0),
            ListTileButton(
                leadingIcon: Icons.delete,
                title: 'Delete',
                onTap: (){
                  queryHandler.delete(group.id);
                  Navigator.pop(context);}),
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

  Widget addGroupSheet(){
    nameController.text   = 'group_1';
    dateController.text   = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('New project group', style: TextStyle(color: Colors.white)),
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
            Divider(height: 0),
            ListTileButton(
              leadingIcon: Icons.add,
              title: 'Create',
              onTap: (){
                queryHandler.add(
                    name : nameController.text,
                    createdOn : dateController.text,
                    color : RandomColor.getColorHex,
                    email: userDetails.userEmail);
                Navigator.pop(context);}),
            Divider(height: 0),
            ListTileButton(
            leadingIcon: Icons.cancel,
            title: 'Cancel',
            onTap: () => Navigator.pop(context)),
            Divider(height: 0),
          ],
        ));
  }

  Widget accountDialog(String userName, String userEmail, String userLogoUrl) => AlertDialog(
    content: Container(
      height: 200,
      child: Center(
        child: Column(
          children: <Widget>[
            Spacer(flex: 1,),
            Container(
                padding: EdgeInsets.all(5),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: new DecorationImage(image: NetworkImage(userLogoUrl)))
            ),
            Text(userName,
                style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
            Padding(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: Text(userEmail)),
            Spacer(flex: 2,),
            Divider(height: 0),
            ListTile(
                title: Center(child: Text('Sign out')),
                onTap: () async {
                  await GoogleAuthService().signOut();
                  Navigator.pushNamedAndRemoveUntil(context, RouterService.sign_in_page_route, (Route<dynamic> route) => false);},
                dense: true),
            Divider(height: 0),
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}