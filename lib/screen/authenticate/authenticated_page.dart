import 'dart:developer';
import 'package:a_good_app/models/user_model.dart';
import 'package:a_good_app/screen/home/home.dart';
import 'package:a_good_app/services/auth_service.dart';
import 'package:a_good_app/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class AuthenticatedPage extends StatefulWidget {
  const AuthenticatedPage({Key? key}) : super(key: key);

  @override
  State<AuthenticatedPage> createState() => _AuthenticatedPageState();
}

class _AuthenticatedPageState extends State<AuthenticatedPage> {
  final AuthService _authService = AuthService();

  @override
  initState() {
    super.initState();
   // DataBaseService().getUserDocument(Provider.of<User>(context).uid);
  }

  asd() {
    DataBaseService().getUserDocument(Provider.of<User>(context).uid);
  }

  @override
  Widget build(BuildContext context) {
    DataBaseService().userList.first.then((value) => print(value.first.totalPower));
    return StreamProvider<List<UserModel>?>.value(
      initialData: null,
      value: DataBaseService().userList,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Authenticated"),
          actions: [
            IconButton(
                onPressed: () async {
                  var _result = await _authService.signOut();
                  log(_result.toString());
                  if (_result == false) {
                    Get.snackbar(
                      "Uyarı",
                      "Bir sorun oluştu",
                    );
                  } else {
                    Get.rawSnackbar(messageText: const Text("Çıkış başarılı"));
                    debugPrint(_result.toString());
                    Get.offAll(() => const Home());
                  }
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body:const DocumentList(),
      ),
    );
  }
}
class DocumentList extends StatelessWidget {
  const DocumentList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child:Provider.of<List<UserModel>?>(context)==null?Text("boş"):ListView.builder(
          itemCount:Provider.of<List<UserModel>?>(context)!.length ,
          itemBuilder: (context, index) => ListTile(
            title: Text(context.read<List<UserModel>>()[index].totalAttendance!),
          )),
    );
  }
}
