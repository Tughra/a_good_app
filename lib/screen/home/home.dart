import 'package:a_good_app/core/notification_service.dart';
import 'package:a_good_app/screen/authenticate/authenticate.dart';
import 'package:a_good_app/screen/authenticate/authenticated_page.dart';
import 'package:a_good_app/screen/authenticate/user_page.dart';
import 'package:a_good_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),),
      body: Container(
        child: Center(child: Column(
          children: [
            TextButton(child:const Text("Go Login"),onPressed: (){
              Get.to(()=>Authentication());
            },),
            TextButton(child:const Text("Sign in with google"),onPressed: (){

            },),
            TextButton(child:const Text("Sign in with facebook"),onPressed: (){
          LocalNotificationService.instance.showNotification(hashcode: 1, payload: "payload",title: "asdsa",body: "asdsadsadas");
            },),
            TextButton(child:const Text("Sign in anonymously"),onPressed: (){
              _authService.signInAnonymous().then((value){
                if(value==null){
                  Get.snackbar("Uyarı", "Kullanıcı Bulunamadı",);
                }else{
                  Get.rawSnackbar(messageText:const Text("Başarılı"));
                  Get.offAll(()=>const AuthenticatedPage());
                }
              });
            },)

          ],
        ),),
      ),
    );
  }
}
