import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projects_management/components/mat_components.dart';
import 'package:projects_management/pages/details/tabs/notes/note.dart';
import 'package:projects_management/pages/details/tabs/notes/note_query_handler.dart';
import 'package:projects_management/pages/projects/project.dart';
import 'package:projects_management/services/random_color_service.dart';
import 'package:projects_management/values/values.dart';

// ignore: must_be_immutable
class NotesTab extends StatefulWidget{
  Project project;
  NotesTab({this.project});
  @override NotesTabState createState() => NotesTabState();
}
class NotesTabState extends State<NotesTab> with AutomaticKeepAliveClientMixin<NotesTab>{
  final GlobalKey<ScaffoldState>    scaffoldKey       = GlobalKey<ScaffoldState>();
  final                             nameController    = TextEditingController();
  final                             contentController = TextEditingController();
  final                             dateController    = TextEditingController();
  List<Note>                        notes             = new List();
  StreamSubscription<QuerySnapshot> querySnapshot;
  NoteQueryHandler                  queryHandler      = NoteQueryHandler();

  @override void initState() {
    super.initState();
    querySnapshot?.cancel();
    querySnapshot = queryHandler
        .collection
        .where(Keys.projectId, isEqualTo: widget.project.id)
        .snapshots()
        .listen((QuerySnapshot snapshot) => setState(() =>
    notes = snapshot
        .documents
        .map((documentSnapshot) => Note.fromMap(documentSnapshot.data)).toList()));
  }
  @override void dispose() {
    super.dispose();
    querySnapshot?.cancel();
  }

  @override bool get wantKeepAlive => true;
  // ignore: must_call_super
  @override Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: Container(
              width: constraints.maxWidth < 600 ? constraints.maxWidth : 600,
              child: notes.length <= 0 ?
              Center(
                  child: Text("No notes found",
                  style: TextStyle(fontSize: constraints.maxWidth < 600 ? 16 : 30 ))) :
              ListView(
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: notes.length,
                        itemBuilder: (_, int index) => runningCard(
                            context: context,
                            title: notes[index].name,
                            subtitle: notes[index].createdOn,
                            leadingIcon: Icons.assignment,
                            color: Color(int.parse(notes[index].color)),
                            onLongPress: () => scaffoldKey.currentState.showBottomSheet((context) => editNoteSheet(notes[index])))),
                  ])
              ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 5,
        tooltip: 'Add new note',
        onPressed: () => scaffoldKey.currentState.showBottomSheet((context) => addNoteSheet()),
      ),
    );
  }

  Widget editNoteSheet(Note note){
    nameController.text = note.name;
    contentController.text = note.content;
    dateController.text = note.createdOn;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('Edit Note', style: TextStyle(color: Colors.white)),
            backgroundColor: Color(int.parse(note.color)),
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
            Divider(height: 0),
            ListTileButton(
                leadingIcon: Icons.update,
                title: 'Update',
                onTap: (){
                  queryHandler.update(Note(
                      id: note.id,
                      name: nameController.text,
                      content: contentController.text,
                      createdOn: dateController.text,
                      color: note.color,
                      projectId: note.projectId,
                      groupId: note.groupId));
                  Navigator.pop(context);}),
            Divider(height: 0),
            ListTileButton(
                leadingIcon: Icons.delete,
                title: 'Delete',
                onTap: (){
                  queryHandler.delete(note.id);
                  Navigator.pop(context);}),
            Divider(height: 0),
            ListTileButton(
                leadingIcon: Icons.cancel,
                title: 'Cancel',
                onTap: () => Navigator.pop(context)),
            Divider(height: 0),
          ],
        )
    );}

  Widget addNoteSheet(){
    nameController.text = 'note_1';
    contentController.text = '';
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('New Note', style: TextStyle(color: Colors.white)),
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
                      projectId : widget.project.id,
                      groupId   : widget.project.groupId,
                      email     :  widget.project.email);
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