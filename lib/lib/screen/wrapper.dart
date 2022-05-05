import 'package:a_good_app/screen/authenticate/authenticated_page.dart';
import 'package:a_good_app/screen/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user=Provider.of<User?>(context);
    print(user);
    if(user==null) {
      return Home();
    } else {
      return const AuthenticatedPage();
    }
  }
}
