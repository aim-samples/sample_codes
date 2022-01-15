import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:project_management/components/components.dart';
import 'package:project_management/pages/projects/project.dart';
import 'package:project_management/services/services.dart';
import 'package:project_management/values/values.dart';
import 'goal.dart';
import 'goal_query_handler.dart';
import 'note.dart';
import 'note_query_handler.dart';

class ContentsPage extends StatefulWidget{
  @override _ContentsPageState createState() => _ContentsPageState();
}

class _ContentsPageState extends State<ContentsPage> with SingleTickerProviderStateMixin{
  GlobalKey<ScaffoldState>          scaffoldKey           = new GlobalKey<ScaffoldState>();
  final                             nameController        = new TextEditingController();
  final                             createdOnController   = new TextEditingController();
  final                             contentController     = new TextEditingController();
  final                             statusController      = new TextEditingController();
  TabController                     tabController         ;
  Project                           project               ;
  UserDetails                       userDetails           ;
  //goals
  List<Goal>                        runningGoals          = new List();
  List<Goal>                        completedGoals        = new List();
  List<Goal>                        cancelledGoals        = new List();
  StreamSubscription<QuerySnapshot> runningQuerySnapshot  ;
  StreamSubscription<QuerySnapshot> completedQuerySnapshot;
  StreamSubscription<QuerySnapshot> cancelledQuerySnapshot;
  GoalQueryHandler                  goalQueryHandler      = new GoalQueryHandler();
  //notes
  List<Note>                        notes                 = new List();
  StreamSubscription<QuerySnapshot> noteQuerySnapshot     ;
  NoteQueryHandler                  noteQueryHandler      = new NoteQueryHandler();
  @override void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 2);
    runningQuerySnapshot?.cancel();
    completedQuerySnapshot?.cancel();
    cancelledQuerySnapshot?.cancel();
    noteQuerySnapshot?.cancel();
  }
  @override void dispose() {
    super.dispose();
    runningQuerySnapshot?.cancel();
    completedQuerySnapshot?.cancel();
    cancelledQuerySnapshot?.cancel();
    noteQuerySnapshot?.cancel();}
  void init(context) {
    project = Project.fromMap((ModalRoute
        .of(context)
        .settings
        .arguments as RoutingArguments).content);
    userDetails = (ModalRoute
        .of(context)
        .settings
        .arguments as RoutingArguments).userDetails;
    runningQuerySnapshot = goalQueryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.running)
        .where(Keys.projectId, isEqualTo: project.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    runningGoals = snapshot
        .documents
        .map((documentSnapshot) => Goal.fromMap(documentSnapshot.data)).toList()));

    completedQuerySnapshot = goalQueryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.completed)
        .where(Keys.projectId, isEqualTo: project.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    completedGoals = snapshot
        .documents
        .map((documentSnapshot) => Goal.fromMap(documentSnapshot.data)).toList()));

    cancelledQuerySnapshot = goalQueryHandler
        .collection
        .where(Keys.status, isEqualTo: Status.cancelled)
        .where(Keys.projectId, isEqualTo: project.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    cancelledGoals = snapshot
        .documents
        .map((documentSnapshot) => Goal.fromMap(documentSnapshot.data)).toList()));
    noteQuerySnapshot = noteQueryHandler
        .collection
        .where(Keys.projectId, isEqualTo: project.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    notes = snapshot
        .documents
        .map((documentSnapshot) => Note.fromMap(documentSnapshot.data)).toList()));
  }
  @override Widget build(BuildContext context) {
    init(context);
    return DefaultTabController(
      length: 2,
      child: mainScaffold(
        context: context,
        key: scaffoldKey,
        titleText: project.name,
        userDetails: userDetails,
        bottom: TabBar(
          controller: tabController,
          labelStyle: CustomTextStyle.ralewayBoldWithSpace2,
          indicatorColor: chooseColorFromBrightness(context),
          labelColor: chooseColorFromBrightness(context),
          tabs: <Widget>[
            Tab(text: Strings.tab_goals),
            Tab(text: Strings.tab_notes),],),
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
              runningGoals.length + completedGoals.length + cancelledGoals.length <= 0 ? NoDataFoundUI() : goalsUI(),
              notes.length <= 0 ? NoDataFoundUI() : notesUI(),],),),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(ConstantIcons.create),
          label: Text(Strings.operation_create_title,
            style: CustomTextStyle.firaCodeBold,),
          tooltip: Strings.create_new_group,
          onPressed: () => scaffoldKey.currentState.showBottomSheet((context) =>
          tabController.index == 0 ? addGoalSheet() : addNoteSheet(),),),),);
  }

  Widget get runningGoalsListViewTitleCard   => ListTitleCard(
    title: Strings.running_goals,
    trailingIcon: ConstantIcons.running,
    foregroundColor: ConstantColors.running,
    visible: runningGoals.length > 0 ? true : false,);
  Widget get completedGoalsListViewTitleCard => ListTitleCard(
    title: Strings.completed_goals,
    trailingIcon: ConstantIcons.completed,
    foregroundColor: ConstantColors.completed,
    visible: completedGoals.length > 0 ? true : false,);
  Widget get cancelledGoalsListViewTitleCard => ListTitleCard(
    title: Strings.cancelled_goals,
    trailingIcon: ConstantIcons.cancelled,
    foregroundColor: ConstantColors.cancelled,
    visible: cancelledGoals.length > 0 ? true : false,);
  Widget get runningGoalListView    => goalListUI(goals: runningGoals);
  Widget get completedGoalListView  => goalListUI(goals: completedGoals);
  Widget get cancelledGoalListView  => goalListUI(goals: cancelledGoals);
  Widget goalListUI({List<Goal> goals}) => ListView.builder(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemCount: goals.length,
    itemBuilder: (context, index) => ProjectCard(
      color: RandomColor.getColorFromHex(goals[index].color),
      leadingIcon: ConstantIcons.goal,
      titleText: goals[index].name,
      trailingText: goals[index].createdOn,
      onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) => editGoalSheet(goals[index]),),),);
  Widget goalsUI() => LayoutBuilder(
    builder: (context, constraints) => Center(
      child: Container(
        width: constraints.maxWidth < Dimensions.max_width ? constraints.maxWidth : Dimensions.max_width,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            StickyHeader(
              header: runningGoalsListViewTitleCard,
              content: runningGoalListView,),
            StickyHeader(
              header: completedGoalsListViewTitleCard,
              content: completedGoalListView,),
            StickyHeader(
              header: cancelledGoalsListViewTitleCard,
              content: cancelledGoalListView,),],),),),);
  Widget notesUI() => ListView.builder(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemCount: notes.length,
    itemBuilder: (context, index) => ProjectCard(
      color: RandomColor.getColorFromHex(notes[index].color),
      leadingIcon: ConstantIcons.note,
      titleText: notes[index].name,
      trailingText: notes[index].createdOn,
      onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) => editNoteSheet(notes[index]),),),);

  Widget addGoalSheet(){
    nameController.text = Strings.new_goal;
    contentController.text = '';
    createdOnController.text = DateFormat(Strings.date_format).format(DateTime.now());
    statusController.text = Status.running;
    return OperationSheet(
      titleText: Strings.create_new_goal,
      children: <Widget>[
        TextInput(
          controller: nameController,
          prefixIcon: ConstantIcons.name,
          labelText: Strings.label_name,),
        TextInputMultiLine(
          controller: contentController,
          prefixIcon: ConstantIcons.content,
          labelText: Strings.label_content,),
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
          onTap: addGoal,),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.cancel,
          titleText: Strings.operation_cancel_title,
          onTap: () => RouterService.goBack(context),),
        Divider(height: 0),],);}
  Widget editGoalSheet(Goal goal){
    nameController.text = goal.name;
    contentController.text = goal.content;
    createdOnController.text = goal.createdOn;
    statusController.text = goal.status;
    return OperationSheet(
      titleText: Strings.edit_goal,
      children: <Widget>[
        TextInput(
          controller: nameController,
          prefixIcon: ConstantIcons.name,
          labelText: Strings.label_name,),
        TextInputMultiLine(
          controller: contentController,
          prefixIcon: ConstantIcons.content,
          labelText: Strings.label_content,),
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
          onTap: () => updateGoal(goal),),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.delete,
          titleText: Strings.operation_delete_title,
          onTap: () => confirmDeleteGoal(goal),),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.cancel,
          titleText: Strings.operation_cancel_title,
          onTap: () => RouterService.goBack(context),),
        Divider(height: 0),],);
  }

  Widget addNoteSheet(){
    nameController.text = Strings.new_note;
    contentController.text = '';
    createdOnController.text = DateFormat(Strings.date_format).format(DateTime.now());
    return OperationSheet(
      titleText: Strings.create_new_note,
      children: <Widget>[
        TextInput(
          controller: nameController,
          prefixIcon: ConstantIcons.name,
          labelText: Strings.label_name,),
        TextInputMultiLine(
          controller: contentController,
          prefixIcon: ConstantIcons.content,
          labelText: Strings.label_content,),
        TextInput(
          controller: createdOnController,
          prefixIcon: ConstantIcons.created_on,
          labelText: Strings.label_created_on,),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.create,
          titleText: Strings.operation_create_title,
          onTap: addNote,),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.cancel,
          titleText: Strings.operation_cancel_title,
          onTap: () => RouterService.goBack(context),),
        Divider(height: 0),],);
  }
  Widget editNoteSheet(Note note){
    nameController.text = note.name;
    contentController.text = note.content;
    createdOnController.text = note.createdOn;
    return OperationSheet(
      titleText: Strings.edit_note,
      children: <Widget>[
        TextInput(
          controller: nameController,
          prefixIcon: ConstantIcons.name,
          labelText: Strings.label_name,),
        TextInputMultiLine(
          controller: contentController,
          prefixIcon: ConstantIcons.content,
          labelText: Strings.label_content,),
        TextInput(
          controller: createdOnController,
          prefixIcon: ConstantIcons.created_on,
          labelText: Strings.label_created_on,),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.update,
          titleText: Strings.operation_update_title,
          onTap: () => updateNote(note),),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.delete,
          titleText: Strings.operation_delete_title,
          onTap: () => confirmDeleteNote(note),),
        Divider(height: 0),
        ListTileButton(
          leadingIcon: ConstantIcons.cancel,
          titleText: Strings.operation_cancel_title,
          onTap: () => RouterService.goBack(context),),
        Divider(height: 0),],);
  }
  //fireStore operations
  //goals management
  void addGoal() async {
    showSnackBar(Strings.creating_goal);
    goalQueryHandler.add(goal: Goal(
      name: nameController.text,
      content: contentController.text,
      createdOn: createdOnController.text,
      color: RandomColor.getColorInHex,
      status: statusController.text,
      projectId: project.id,
      groupId: project.groupId,
      email: project.email,),).then((result) => RouterService.goBack(context),);
  }
  void confirmDeleteGoal(Goal goal) => RouterService.goBack(context).then(showDialog(
    context: context, builder: (context) => DeleteConfirmDialog(
    itemDetails: goal,
    leadingIcon: ConstantIcons.goal,
    onDelete: () => deleteGoal(goal.id),),),);
  void deleteGoal(id) async {
    showSnackBar(Strings.deleting_goal);
    goalQueryHandler.delete(id).then((result) => RouterService.goBack(context),);
  }
  void updateGoal(goal) async {
    showSnackBar(Strings.updating);
    goalQueryHandler.update(Goal(
      id: goal.id,
      name: nameController.text,
      content: contentController.text,
      createdOn: createdOnController.text,
      color: goal.color,
      status: statusController.text,
      projectId: goal.projectId,
      groupId: goal.groupId,),).then((result) => RouterService.goBack(context));
  }
  //notes managements
  void addNote() async {
    showSnackBar(Strings.creating_note);
    noteQueryHandler.add(note: Note(
      name: nameController.text,
      content: contentController.text,
      createdOn: createdOnController.text,
      color: RandomColor.getColorInHex,
      projectId: project.id,
      groupId: project.groupId,
      email: project.email,),).then((result) => RouterService.goBack(context));
  }
  void confirmDeleteNote(Note note) => RouterService.goBack(context).then(showDialog(
    context: context, builder: (context) => DeleteConfirmDialog(
    itemDetails: note,
    leadingIcon: ConstantIcons.note,
    onDelete: () => deleteNote(note.id),),),);
  void deleteNote(id) async {
    showSnackBar(Strings.deleting_note);
    noteQueryHandler.delete(id).then((result) => RouterService.goBack(context));
  }
  void updateNote(note) async {
    showSnackBar(Strings.updating);
    noteQueryHandler.update(Note(
      id: note.id,
      name: nameController.text,
      content: contentController.text,
      createdOn: createdOnController.text,
      color: note.color,
      projectId: note.projectId,
      groupId: note.groupId,),).then((result) => RouterService.goBack(context));
  }

  void showSnackBar(message) => scaffoldKey.currentState.showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: 1),),);
}