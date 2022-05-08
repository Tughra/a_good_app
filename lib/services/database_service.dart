import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{
  late final String uid;
  DataBaseService.uid({required this.uid}){
    log("named constructor triggered");
  }
  DataBaseService();
  final CollectionReference repoCollection = FirebaseFirestore.instance.collection("repository");
  Future updateUserRepo({required String star,required String attendance,required int power})async{
    return await repoCollection.doc(uid).set({
      "totalStar":star,
      "totalAttendance":attendance,
      "totalPower":power
    });
  }
  Stream<QuerySnapshot> get repoCollections{
    return repoCollection.snapshots();
  }
}