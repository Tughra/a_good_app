import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataBaseService{
  late final String uid;
  DataBaseService.uid({required this.uid}){
    log("named constructor triggered");
  }
  DataBaseService();
  final _fireInstance= FirebaseFirestore.instance;
  final CollectionReference repoCollection = FirebaseFirestore.instance.collection("repository");
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
  Future<Map<String,dynamic>?> getUserDocument(String uid)async{
    print("object");
    print(uid);
    print(( await _fireInstance.collection("repository").doc(uid).get()).data());
    Map<String,dynamic>? data=(await _fireInstance.collection("repository").doc(uid).get()).data();
   return data;
  }
}