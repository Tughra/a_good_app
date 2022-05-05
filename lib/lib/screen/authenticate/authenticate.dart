import 'package:a_good_app/screen/authenticate/authenticated_page.dart';
import 'package:a_good_app/screen/authenticate/user_page.dart';
import 'package:a_good_app/screen/authenticate/user_page_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final User? user=Provider.of<User?>(context);
    if(user==null){
      if(showSignIn==false){
        return UserPage(showSignIn: toggleView);
      }else{
        return RegisterPage(showSignIn: toggleView);
      }
    }else {
      return AuthenticatedPage();
    }
  }
}
