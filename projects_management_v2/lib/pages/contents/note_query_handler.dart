import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_management/services/services.dart';
import 'package:project_management/values/values.dart';
import 'note.dart';

class NoteQueryHandler{
  CollectionReference get collection => CollectionRef.notes;
  Future<bool> add({Note note}) async => FireStoreTransactionService.runTransaction(
    reference       : collection.document(),
    data            : {
      Keys.name     : note.name,
      Keys.content  : note.content,
      Keys.createdOn: note.createdOn,
      Keys.color    : note.color,
      Keys.projectId: note.projectId,
      Keys.groupId  : note.groupId,
      Keys.email    : note.email},
    process         : Process.add,);
  Future<bool> delete(String id) async => FireStoreTransactionService.runTransaction(
    reference       : collection.document(id),
    process         : Process.delete,);
  Future<bool> update(Note note) async => FireStoreTransactionService.runTransaction(
    reference       :  collection.document(note.id),
    data            : {
      Keys.name     : note.name,
      Keys.content  : note.content,
      Keys.createdOn: note.createdOn,
      Keys.color    : note.color,},
    process         : Process.update,);
}