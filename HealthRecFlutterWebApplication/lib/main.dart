import 'package:flutter/material.dart';
import 'package:healthrecweb/pages/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: LogInPage(),
    debugShowCheckedModeBanner: false,
  ));
}