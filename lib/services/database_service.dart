import 'dart:developer';
import 'package:a_good_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class DataBaseService{
  late final String uid;
  DataBaseService.uid({required this.uid}){
    log("named constructor triggered");
  }
  DataBaseService();
  final _fireInstance= FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> repoCollection = FirebaseFirestore.instance.collection("repository");
  Future updateUserRepo({required String star,required String attendance,required int power})async{
    return await repoCollection.doc(uid).set({
      "totalStar":star,
      "totalAttendance":attendance,
      "totalPower":power
    });
  }
  Stream<QuerySnapshot?> get repoCollections{
    return repoCollection.snapshots();
  }
   List<UserModel> _userModelsFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot){
  List<UserModel> userModelList =snapshot.docs.map((element) {
   return UserModel.fromJson(element.data());
  }).toList();
  return userModelList;
     //UserModel.fromJson("");
/*
 DocumentReference document = locationRecordingsCollection.document((location));

 DocumentSnapshot documentSnapshot =  await document.get();
 var data = LocationRecordings.fromJson(documentSnapshot.data);
 */
  }
  Stream<List<UserModel>> get userList{
//    QuerySnapshot<Map<String, dynamic>> snapshot = repoCollection.snapshots().first;
    return repoCollection.snapshots().map(_userModelsFromSnapshot);
  }
  Future<Map<String,dynamic>?> getUserDocument(String uid)async{
    print("object");
    print(uid);
    print(( await _fireInstance.collection("repository").doc(uid).get()).data());
    Map<String,dynamic>? data=(await _fireInstance.collection("repository").doc(uid).get()).data();
   return data;
  }
}