import 'package:bluehome/values/values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FireStoreTransactionService{
  static Future<bool> runTransaction({DocumentReference reference, Map<String, dynamic> data, String process}) async {
    Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot = await transaction.get(reference);
      if(process == Process.add)  data[Keys.id] = documentSnapshot.documentID;
      process == Process.add    ? await transaction.set(documentSnapshot.reference, data)     :
      process == Process.delete ? await transaction.delete(documentSnapshot.reference)        :
      process == Process.update ? await transaction.update(documentSnapshot.reference, data)  :
      print(Strings.no_operation_found);
      return {Strings.label_success : true};})
        .then((result) => print(result[Strings.label_success]))
        .catchError((error) => print(error));
    return true;
  }
}

class CollectionRef{
  static CollectionReference get fields => Firestore.instance.collection(FireStoreCollection.fields);
}