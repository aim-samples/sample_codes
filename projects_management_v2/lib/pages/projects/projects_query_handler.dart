import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_management/services/services.dart';
import 'package:project_management/values/values.dart';
import 'project.dart';

class ProjectQueryHandler{
  CollectionReference get collection => CollectionRef.projects;
  Future<bool> add({Project project}) async => FireStoreTransactionService.runTransaction(
    reference       : collection.document(),
    data            : {
      Keys.name     : project.name,
      Keys.createdOn: project.createdOn,
      Keys.color    : project.color,
      Keys.groupId  : project.groupId,
      Keys.status   : project.status,
      Keys.email    : project.email,},
    process         : Process.add,);
  Future<bool> delete(String id) async => FireStoreTransactionService.runTransaction(
    reference       : collection.document(id),
    process         : Process.delete,);
  Future<bool> update(Project project) async => FireStoreTransactionService.runTransaction(
    reference       : collection.document(project.id),
    data            : {
      Keys.name     : project.name,
      Keys.createdOn: project.createdOn,
      Keys.color    : project.color,
      Keys.status   : project.status,},
    process         : Process.update,);
//  void deleteAllGoals({String key, String value}) async {
//    List<Goal> goals  = List();
//    StreamSubscription query = CollectionRef.goals
//        .where(key, isEqualTo: value)
//        .snapshots()
//        .listen((querySnapshot) => goals = querySnapshot
//        .documents
//        .map((documentSnapshot) => Goal.fromMap(documentSnapshot.data)).toList());
//    query?.cancel();
//    goals.forEach((goal) => FireStoreTransactionService.runTransaction(
//        reference: CollectionRef.goals.document(goal.id),
//        process: Process.delete));
//  }
//  void deleteAllNotes({String key, String value}) async {
//    List<Note> notes  = List();
//    StreamSubscription query = CollectionRef.notes
//        .where(key, isEqualTo: value)
//        .snapshots()
//        .listen((querySnapshot) => notes = querySnapshot
//        .documents
//        .map((documentSnapshot) => Note.fromMap(documentSnapshot.data)).toList());
//    query?.cancel();
//    notes.forEach((note) => FireStoreTransactionService.runTransaction(
//        reference: CollectionRef.notes.document(note.id),
//        process: Process.delete
//    ));
//  }
}