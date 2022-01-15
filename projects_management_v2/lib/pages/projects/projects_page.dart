import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_management/components/components.dart';
import 'package:project_management/services/services.dart';
import 'package:project_management/values/values.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:project_management/pages/groups/group.dart';
import 'project.dart';
import 'projects_query_handler.dart';

class ProjectsPage extends StatefulWidget{
  @override _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  GlobalKey<ScaffoldState>          scaffoldKey         = GlobalKey<ScaffoldState>();
  List<Project>                     runningProjects     = new List();
  List<Project>                     completedProjects   = new List();
  List<Project>                     cancelledProjects   = new List();
  final                             nameController      = new TextEditingController();
  final                             createdOnController = new TextEditingController();
  final                             statusController    = new TextEditingController();
  Group                             group;
  StreamSubscription<QuerySnapshot> runningQuerySnapshot;
  StreamSubscription<QuerySnapshot> completedQuerySnapshot;
  StreamSubscription<QuerySnapshot> cancelledQuerySnapshot;
  ProjectQueryHandler               queryHandler        = ProjectQueryHandler();
  UserDetails                       userDetails;
  @override void initState() {
    super.initState();
    runningQuerySnapshot?.cancel();
    completedQuerySnapshot?.cancel();
    cancelledQuerySnapshot?.cancel();}
  @override void dispose() {
    super.dispose();
    runningQuerySnapshot?.cancel();
    completedQuerySnapshot?.cancel();
    cancelledQuerySnapshot?.cancel();}
  void init(context)  {
    group = Group.fromMap((ModalRoute
        .of(context)
        .settings
        .arguments as RoutingArguments).content);
    userDetails = (ModalRoute
        .of(context)
        .settings
        .arguments as RoutingArguments).userDetails;
    runningQuerySnapshot = queryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.running)
        .where(Keys.groupId, isEqualTo: group.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    runningProjects = snapshot
        .documents
        .map((documentSnapshot) => Project.fromMap(documentSnapshot.data)).toList(),),);
    completedQuerySnapshot = queryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.completed)
        .where(Keys.groupId, isEqualTo: group.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    completedProjects = snapshot
        .documents
        .map((documentSnapshot) => Project.fromMap(documentSnapshot.data)).toList()));

    cancelledQuerySnapshot = queryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.cancelled)
        .where(Keys.groupId, isEqualTo: group.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    cancelledProjects = snapshot
        .documents
        .map((documentSnapshot) => Project.fromMap(documentSnapshot.data)).toList()));
  }
  @override Widget build(BuildContext context) {
    init(context);
    return mainScaffold(
      context: context,
      key: scaffoldKey,
      titleText: group.name,
      userDetails: userDetails,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: Container(
              width: constraints.maxWidth < Dimensions.max_width ? constraints.maxWidth : Dimensions.max_width,
              child: runningProjects.length + completedProjects.length + cancelledProjects.length <= 0 ?
              NoDataFoundUI() : projectsUI(),),),),),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(ConstantIcons.create),
        label: Text(Strings.operation_create_title, style: CustomTextStyle.firaCodeBold),
        tooltip: Strings.create_new_project,
        onPressed: () => scaffoldKey.currentState.showBottomSheet((context) => addProjectSheet(),),),);
  }
  Widget projectsUI() => ListView(
    physics: ClampingScrollPhysics(),
    children: <Widget>[
      StickyHeader(
        header: runningProjectsListViewTitleCard,
        content: runningProjectsListView,),
      StickyHeader(
        header: completedProjectsListViewTitleCard,
        content: completedProjectsListView,),
      StickyHeader(
        header: cancelledProjectsListViewTitleCard,
        content: cancelledProjectsListView,),],);
  Widget get runningProjectsListViewTitleCard   => ListTitleCard(
    title: Strings.running_projects,
    trailingIcon: ConstantIcons.running,
    foregroundColor: ConstantColors.running,
    visible: runningProjects.length > 0 ? true : false,);
  Widget get completedProjectsListViewTitleCard => ListTitleCard(
    title: Strings.completed_projects,
    trailingIcon: ConstantIcons.completed,
    foregroundColor: ConstantColors.completed,
    visible: completedProjects.length > 0 ? true : false,);
  Widget get cancelledProjectsListViewTitleCard => ListTitleCard(
    title: Strings.cancelled_projects,
    trailingIcon: ConstantIcons.cancelled,
    foregroundColor: ConstantColors.cancelled,
    visible: cancelledProjects.length > 0 ? true : false,);
  Widget get runningProjectsListView            => projectsListView( projects: runningProjects);
  Widget get completedProjectsListView          => projectsListView( projects: completedProjects);
  Widget get cancelledProjectsListView          => projectsListView( projects: cancelledProjects);
  Widget projectsListView({List<Project> projects}) => ListView.builder(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemCount: projects.length,
    itemBuilder: (context, index) => ProjectCard(
      color: RandomColor.getColorFromHex(projects[index].color),
      leadingIcon: ConstantIcons.project,
      titleText: projects[index].name,
      trailingText: projects[index].createdOn,
      onTap: () => Navigator.pushNamed(
        context,
        RouterService.contents_page_route,
        arguments: RoutingArguments(content: projects[index].toMap, userDetails: userDetails,),),
      onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) => editProjectSheet(projects[index],),),),);

  Widget addProjectSheet(){
    nameController.text = Strings.new_project;
    createdOnController.text = DateFormat(Strings.date_format).format(DateTime.now());
    statusController.text = Status.running;
    return OperationSheet(
      titleText: Strings.create_new_project,
      children: <Widget>[
        TextInput(
          controller: nameController,
          prefixIcon: ConstantIcons.name,
          labelText: Strings.label_name,),
        TextInput(
          controller: createdOnController,
          prefixIcon: ConstantIcons.created_on,
          labelText: Strings.label_created_on,),
        TextInputSelect(
          controller: statusController,
          prefixIcon: ConstantIcons.status,
          labelText: Strings.label_current_status,
          items: Status.all,),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.create,
          titleText: Strings.operation_create_title,
          onTap: addProject,),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.cancel,
          titleText: Strings.operation_cancel_title,
          onTap: () => RouterService.goBack(context),),
        Divider(height: 0),],
    );
  }
  Widget editProjectSheet(Project project){
    nameController.text = project.name;
    createdOnController.text = project.createdOn;
    statusController.text = project.status;
    return OperationSheet(
      titleText: Strings.edit_project,
      children: <Widget>[
        TextInput(
          controller: nameController,
          prefixIcon: ConstantIcons.name,
          labelText: Strings.label_name,),
        TextInput(
          controller: createdOnController,
          prefixIcon: ConstantIcons.created_on,
          labelText: Strings.label_created_on,),
        TextInputSelect(
          controller: statusController,
          prefixIcon: ConstantIcons.status,
          labelText: Strings.label_current_status,
          items: Status.all,),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.update,
          titleText: Strings.operation_update_title,
          onTap: () => updateProject(project),),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.delete,
          titleText: Strings.operation_delete_title,
          onTap: () => confirmDeleteProject(project),),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.cancel,
          titleText: Strings.operation_cancel_title,
          onTap: () => RouterService.goBack(context),),
        Divider(height: 0),],
    );
  }
  void addProject() async {
    showSnackBar(Strings.creating_project);
    queryHandler.add(project: Project(
      name: nameController.text,
      createdOn: createdOnController.text,
      status: statusController.text,
      color: RandomColor.getColorInHex,
      groupId: group.id,
      email: group.email,),).then((result) => RouterService.goBack(context));
  }
  void confirmDeleteProject(Project project) => RouterService.goBack(context).then(showDialog(
    context: context, builder: (context) => DeleteConfirmDialog(
    itemDetails: project,
    leadingIcon: ConstantIcons.project,
    onDelete: () => deleteProject(project.id),),),);
  void deleteProject(id) async {
    showSnackBar(Strings.deleting_project);
    queryHandler.delete(id).then((result) => RouterService.goBack(context),);
  }
  void updateProject(project) async {
    showSnackBar(Strings.updating);
    queryHandler.update(Project(
      id: project.id,
      name: nameController.text,
      createdOn: createdOnController.text,
      status: statusController.text,
      color: project.color,
      groupId: project.groupId,),).then((result) => RouterService.goBack(context),);
  }

  void showSnackBar(message) => scaffoldKey.currentState.showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: 1),),);
}