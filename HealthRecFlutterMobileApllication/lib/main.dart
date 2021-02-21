import 'package:flutter/material.dart';
import 'package:healthrec/pages/Homepage.dart';
import 'package:healthrec/pages/LoginPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:healthrec/pages/Profile.dart';
import 'package:healthrec/pages/Signuppage.dart';
import 'package:healthrec/services/AuthCheck.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: AuthCheck(),
    debugShowCheckedModeBanner: false,
  ));
}