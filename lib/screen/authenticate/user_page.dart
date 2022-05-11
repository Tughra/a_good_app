import 'dart:developer';
import 'package:a_good_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPage extends StatefulWidget {
  final VoidCallback showSignIn;
  const UserPage({Key? key,required this.showSignIn}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controllerName=TextEditingController();
  final controllerPass=TextEditingController();
  final AuthService _authService = AuthService();
  @override
  void dispose() {
    controllerName.dispose();
    controllerPass.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In"),
          actions: [IconButton(onPressed: (){
            widget.showSignIn();
          }, icon: const Icon(Icons.account_circle_rounded))]),
      body: Form(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(margin: EdgeInsets.symmetric(horizontal: 50),
              width: double.infinity,
              child: TextFormField(
                decoration: InputDecoration(hintText: "Type your name"),
                controller: controllerName,
              ),),
            SizedBox(height: 30,),
            Container(margin: EdgeInsets.symmetric(horizontal: 50),
                width: double.infinity,
              child: TextFormField(
                decoration: InputDecoration(hintText: "Type your pass"),
                controller: controllerPass,
              ),
                ),
            SizedBox(height: 30,),
            MaterialButton(onPressed: () async {
              var _result = await _authService.signIn(email: controllerName.text, password: controllerPass.text);
              if (_result == null) {
                Get.snackbar("Uyarı", "Kullanıcı Bulunamadı",);
              } else {
                Get.rawSnackbar(messageText: const Text("Başarılı"));
                debugPrint(_result.toString());
              }
            }, child: Text("Login"),),
          ],
        ),
      ),
    );
  }
}
/*
Column(
        children: [
          SizedBox(height: 30,),
          Container(margin: EdgeInsets.symmetric(horizontal: 50),width: double.infinity,child: TextFormField(),),
          SizedBox(height: 30,),
          Container(margin: EdgeInsets.symmetric(horizontal: 50),width: double.infinity,child: TextFormField(),)
],
      )
 */