import 'package:cloud_firestore/cloud_firestore.dart';
import 'goal.dart';
import 'package:projects_management/services/services.dart';
import 'package:projects_management/values/values.dart';
class GoalQueryHandler{
  CollectionReference get collection => CollectionRef.goals;
  Future<bool> add({String name, String content, String createdOn, String color, String status, String projectId, String groupId, String email}) async =>
      FireStoreTransactionService.runTransaction(
          reference         : collection.document(),
          data              : {
            Keys.name       : name,
            Keys.content    : content,
            Keys.createdOn  : createdOn,
            Keys.color      : color,
            Keys.status     : status,
            Keys.projectId  : projectId,
            Keys.groupId    : groupId,
            Keys.email      : email},
          process           : Process.add);
  Future<bool> delete(String id) async =>
      FireStoreTransactionService.runTransaction(
          reference         : collection.document(id),
          process           : Process.delete);
  Future<bool> update(Goal data) async =>
      FireStoreTransactionService.runTransaction(
          reference         :  collection.document(data.id),
          data              : {
            Keys.name       : data.name,
            Keys.content    : data.content,
            Keys.createdOn  : data.createdOn,
            Keys.color      : data.color,
            Keys.status     : data.status},
          process           : Process.update);
}