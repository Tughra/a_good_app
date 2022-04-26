import 'package:a_good_app/screen/authenticate/user_page.dart';
import 'package:a_good_app/screen/authenticate/user_page_register.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn=false;
  void toggleView(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn==false){
      return UserPage(showSignIn: toggleView);
    }else{
      return RegisterPage(showSignIn: toggleView);
    }
  }
}
