import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseDataBaseHelper {
  FirebaseFirestore database = FirebaseFirestore.instance;
  Future<void>getFirst()async{
   var a= await database.collection("a_good_app_initialize").get();
    log(a.docs.last.data()["description"]);
    debugPrint("bastıı");
  }



}
class FirstModel{
  String title;
  String description;
  FirstModel({required this.title,required this.description});
}