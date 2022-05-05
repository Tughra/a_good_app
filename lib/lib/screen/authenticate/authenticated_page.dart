import 'dart:developer';
import 'package:a_good_app/screen/home/home.dart';
import 'package:a_good_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AuthenticatedPage extends StatefulWidget {
  const AuthenticatedPage({Key? key}) : super(key: key);

  @override
  State<AuthenticatedPage> createState() => _AuthenticatedPageState();
}

class _AuthenticatedPageState extends State<AuthenticatedPage> {
  final AuthService _authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: const Text("Authenticated"),
      actions: [IconButton(onPressed: ()async{
        var _result=await _authService.signOut();
        log(_result.toString());
        if(_result==false){
          Get.snackbar("Uyarı", "Bir sorun oluştu",);
        }else{
          Get.rawSnackbar(messageText:const Text("Çıkış başarılı"));
          debugPrint(_result.toString());
          Get.offAll(()=>const Home());
        }
      }, icon: const Icon(Icons.exit_to_app))],),
      body:const Center(child: Text("Authenticated page"),),
    );
  }
}
