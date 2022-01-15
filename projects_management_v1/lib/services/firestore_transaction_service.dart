import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projects_management/values/values.dart';
class FireStoreTransactionService{
  static Future<bool> runTransaction({DocumentReference reference, Map<String, dynamic> data, String process}) async {
    Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot = await transaction.get(reference);
      if(process == Process.add) data[Keys.id]   = documentSnapshot.documentID;
      process == Process.add    ? await transaction.set(documentSnapshot.reference, data)     :
      process == Process.delete ? await transaction.delete(documentSnapshot.reference)        :
      process == Process.update ? await transaction.update(documentSnapshot.reference, data)  :
      print('No operation set to perform.');
      return {'success' : true};})
        .then((result) => print(result['success']))
        .catchError((error){ print(error); return false;});
    return true;
  }
}
class CollectionRef{
  static CollectionReference get projectGroups  => Firestore.instance.collection('project_groups');
  static CollectionReference get projects       => Firestore.instance.collection('projects');
  static CollectionReference get goals          => Firestore.instance.collection('goals');
  static CollectionReference get notes          => Firestore.instance.collection('notes');
}