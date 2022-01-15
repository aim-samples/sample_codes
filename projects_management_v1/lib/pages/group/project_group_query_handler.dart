import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projects_management/pages/group/project_group.dart';
import 'package:projects_management/services/firestore_transaction_service.dart';
import 'package:projects_management/values/values.dart';
class ProjectGroupQueryHandler{
  CollectionReference get collection => CollectionRef.projectGroups;
  Future<bool> add({String name, String createdOn, String color, String email}) async =>
      FireStoreTransactionService.runTransaction(
          reference       : CollectionRef.projectGroups.document(),
          data            : {
            Keys.name     : name,
            Keys.createdOn: createdOn,
            Keys.color    : color,
            Keys.email    : email},
          process         : Process.add);
  Future<bool> delete(String id) async =>
      FireStoreTransactionService.runTransaction(
          reference       : CollectionRef.projectGroups.document(id),
          process         : Process.delete);
  Future<bool> update(ProjectGroup data) async =>
      FireStoreTransactionService.runTransaction(
          reference       : CollectionRef.projectGroups.document(data.id),
          data            : {
            Keys.name     : data.name,
            Keys.createdOn: data.createdOn,
            Keys.color    : data.color},
          process         : Process.update);
}