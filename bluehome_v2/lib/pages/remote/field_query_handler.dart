import 'package:bluehome/services/services.dart';
import 'package:bluehome/values/values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'field.dart';

class FieldQueryHandler {
  CollectionReference get collection => CollectionRef.fields;
  Future<bool> add({Field field}) async => FireStoreTransactionService.runTransaction(
    reference             : CollectionRef.fields.document(),
    data                  : {
      Keys.color          : field.color,
      Keys.name           : field.name,
      Keys.pinNo          : field.pinNo,
      Keys.status         : false,
      Keys.roomId         : field.roomId,
      Keys.lastUpdatedOn  : field.lastUpdatedOn},
    process               : Process.add,);
  Future<bool> delete({String id}) async => FireStoreTransactionService.runTransaction(
    reference             : CollectionRef.fields.document(id),
    process               : Process.delete,);
  Future<bool> toggle({Field field}) async => FireStoreTransactionService.runTransaction(
    reference             : CollectionRef.fields.document(field.id),
    data                  : { Keys.status : field.status,},
    process               : Process.update,);
  Future<bool> update({Field field}) async => FireStoreTransactionService.runTransaction(
    reference             : CollectionRef.fields.document(field.id),
    data                  : {
      Keys.name           : field.name,
      Keys.pinNo          : field.pinNo,
      Keys.lastUpdatedOn  : field.lastUpdatedOn,},
    process               : Process.update,);
}