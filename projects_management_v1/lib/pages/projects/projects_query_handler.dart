import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projects_management/pages/details/tabs/goals/goal.dart';
import 'package:projects_management/pages/details/tabs/notes/note.dart';
import 'package:projects_management/services/firestore_transaction_service.dart';
import 'package:projects_management/values/values.dart';
import 'project.dart';

class ProjectQueryHandler{
  CollectionReference get collection => CollectionRef.projects;
  Future<bool> add({String name, String createdOn, String color, String groupId, String status, String email}) async =>
      FireStoreTransactionService.runTransaction(
          reference       : collection.document(),
          data            : {
            Keys.name     : name,
            Keys.createdOn: createdOn,
            Keys.color    : color,
            Keys.groupId  : groupId,
            Keys.status   : status,
            Keys.email    : email},
          process         : Process.add);
  Future<bool> delete(String id) async =>
      FireStoreTransactionService.runTransaction(
          reference       : collection.document(id),
          process         : Process.delete);
  Future<bool> update(Project data) async =>
      FireStoreTransactionService.runTransaction(
          reference       : collection.document(data.id),
          data            : {
            Keys.name     : data.name,
            Keys.createdOn: data.createdOn,
            Keys.color    : data.color,
            Keys.status   : data.status},
          process         : Process.update);
  void deleteAllGoals({String key, String value}) async {
    List<Goal> goals  = List();
    StreamSubscription query = CollectionRef.goals
        .where(key, isEqualTo: value)
        .snapshots()
        .listen((querySnapshot) => goals = querySnapshot
        .documents
        .map((documentSnapshot) => Goal.fromMap(documentSnapshot.data)).toList());
    query?.cancel();
    goals.forEach((goal) => FireStoreTransactionService.runTransaction(
        reference: CollectionRef.goals.document(goal.id),
        process: Process.delete));
  }
  void deleteAllNotes({String key, String value}) async {
      List<Note> notes  = List();
      StreamSubscription query = CollectionRef.notes
          .where(key, isEqualTo: value)
          .snapshots()
          .listen((querySnapshot) => notes = querySnapshot
          .documents
          .map((documentSnapshot) => Note.fromMap(documentSnapshot.data)).toList());
      query?.cancel();
      notes.forEach((note) => FireStoreTransactionService.runTransaction(
        reference: CollectionRef.notes.document(note.id),
        process: Process.delete
      ));
  }
}