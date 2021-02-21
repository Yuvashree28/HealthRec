import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthrec/pages/Homepage.dart';
import 'package:healthrec/pages/LoginPage.dart';

class AuthCheck extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {


    final user = FirebaseAuth.instance.currentUser;
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return LogInPage();
    } else {
      return Homepage();
    }


  }


}