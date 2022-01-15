import 'package:cloud_firestore/cloud_firestore.dart';
import 'goal.dart';
import 'package:project_management/services/services.dart';
import 'package:project_management/values/values.dart';
class GoalQueryHandler{
  CollectionReference get collection => CollectionRef.goals;
  Future<bool> add({Goal goal}) async => FireStoreTransactionService.runTransaction(
    reference         : collection.document(),
    data              : {
      Keys.name       : goal.name,
      Keys.content    : goal.content,
      Keys.createdOn  : goal.createdOn,
      Keys.color      : goal.color,
      Keys.status     : goal.status,
      Keys.projectId  : goal.projectId,
      Keys.groupId    : goal.groupId,
      Keys.email      : goal.email,},
    process           : Process.add,);
  Future<bool> delete(String id) async => FireStoreTransactionService.runTransaction(
    reference         : collection.document(id),
    process           : Process.delete,);
  Future<bool> update(Goal goal) async => FireStoreTransactionService.runTransaction(
    reference         : collection.document(goal.id),
    data              : {
      Keys.name       : goal.name,
      Keys.content    : goal.content,
      Keys.createdOn  : goal.createdOn,
      Keys.color      : goal.color,
      Keys.status     : goal.status,},
    process           : Process.update,);
}