import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projects_management/pages/details/tabs/notes/note.dart';
import 'package:projects_management/services/firestore_transaction_service.dart';
import 'package:projects_management/values/values.dart';
class NoteQueryHandler{
  CollectionReference get collection => CollectionRef.notes;
  Future<bool> add({String name, String content, String createdOn, String color, String projectId, String groupId, String email}) async =>
      FireStoreTransactionService.runTransaction(
          reference       : collection.document(),
          data            : {
            Keys.name     : name,
            Keys.content  : content,
            Keys.createdOn: createdOn,
            Keys.color    : color,
            Keys.projectId: projectId,
            Keys.groupId  : groupId,
            Keys.email    : email},
          process         : Process.add);
  Future<bool> delete(String id) async =>
      FireStoreTransactionService.runTransaction(
          reference       : collection.document(id),
          process         : Process.delete);
  Future<bool> update(Note data) async =>
      FireStoreTransactionService.runTransaction(
          reference       :  collection.document(data.id),
          data            : {
            Keys.name     : data.name,
            Keys.content  : data.content,
            Keys.createdOn: data.createdOn,
            Keys.color    : data.color,},
          process         : Process.update);
}