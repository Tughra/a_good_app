import 'dart:developer';
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
    return StreamProvider<QuerySnapshot?>.value(
      initialData: null,
      value: DataBaseService().repoCollections,
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
        body:const DAS(),
      ),
    );
  }
}
class DAS extends StatelessWidget {
  const DAS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Provider.of<QuerySnapshot?>(context)?.docs==null?Text("boş"):ListView.builder(
          itemCount:Provider.of<QuerySnapshot>(context).docs.length ,
          itemBuilder: (context, index) => ListTile(
            title: Text(context.read<QuerySnapshot?>()?.docs[index].id??"1"),
          )),
    );
  }
}
