import 'package:cloud_firestore/cloud_firestore.dart';
import 'group.dart';
import 'package:project_management/services/services.dart';
import 'package:project_management/values/values.dart';
class GroupQueryHandler{
  CollectionReference get collection => CollectionRef.groups;
  Future<bool> add({Group group}) async => FireStoreTransactionService.runTransaction(
    reference       : CollectionRef.groups.document(),
    data            : {
      Keys.name     : group.name,
      Keys.createdOn: group.createdOn,
      Keys.color    : group.color,
      Keys.email    : group.email,},
    process         : Process.add,);
  Future<bool> delete(String id) async => FireStoreTransactionService.runTransaction(
    reference       : CollectionRef.groups.document(id),
    process         : Process.delete,);
  Future<bool> update(Group group) async => FireStoreTransactionService.runTransaction(
    reference       : CollectionRef.groups.document(group.id),
    data            : {
      Keys.name     : group.name,
      Keys.createdOn: group.createdOn,
      Keys.color    : group.color,},
    process         : Process.update,);
}