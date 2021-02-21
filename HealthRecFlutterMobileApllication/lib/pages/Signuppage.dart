import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthrec/pages/Homepage.dart';
import 'LogInPage.dart';




class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _username;
  var _password;

  final usernameCon = new TextEditingController();
  final passwordCon = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(45, 45, 47, 100),
          child: Form(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Center(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,

                    color: Color.fromRGBO(45, 45, 47, 1),
                    alignment: Alignment.center,

                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                new RotatedBox(
                                  quarterTurns: 3,
                                  child: new Text(
                                    'Signup',
                                    style: TextStyle(
                                        fontSize: 50,
                                      color: Color.fromRGBO(250, 189, 13, 1),
                                        fontFamily: "Gruppo",),
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("HealthRec",style: TextStyle(color:Colors.white,fontSize: 50,fontFamily: "SeaweedScript",fontWeight: FontWeight.bold),),
                                    Text("Sign up to assess",style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: "Gruppo")),
                                    //Text("to assess",style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: "Gruppo"),),
                                    Text("your live health data",style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: "Gruppo"),),
                                    //Text("heath data",style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: "Gruppo"),),
                                    SizedBox(height: 20,),
                                    Container(
                                      width: MediaQuery.of(context).size.width/1.6,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Username',
                                            style: TextStyle(color: Colors.white, fontSize: 15),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: 15,
                                            child: TextFormField(
                                              controller: usernameCon,
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontFamily: 'OpenSans'),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(top: 14.0),
                                                hintText: 'Enter your username',
                                                hintStyle: TextStyle(
                                                    color: Colors.white54, fontSize: 12),
                                                suffixIcon: Icon(Icons.perm_identity,
                                                    color: Colors.white
                                                  //color: Colors.black54,
                                                ),
                                              ),
                                              validator: (value) => value.isEmpty
                                                  ? 'Username can\'t be empty'
                                                  : null,
                                              onSaved: (value) => _username = value.trim(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Password',
                                            style: TextStyle(color: Colors.white, fontSize: 15),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: 15,
                                            child: TextFormField(
                                              controller: passwordCon,
                                              obscureText: true,
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontFamily: 'OpenSans'),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(top: 14.0),
                                                hintText: 'Enter your password',
                                                hintStyle: TextStyle(
                                                    color: Colors.white54, fontSize: 12),
                                                suffixIcon:
                                                Icon(Icons.lock, color: Colors.white),
                                              ),
                                              validator: (value) => value.isEmpty
                                                  ? 'Password can\'t be empty'
                                                  : null,
                                              onSaved: (value) => _password = value.trim(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),


                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                            SizedBox(height: 40,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RaisedButton(
                                  padding: EdgeInsets.fromLTRB(30, 7, 30, 7),
                                  onPressed: () {
                                    print('Signed up');
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Homepage()));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  color: Color.fromRGBO(250, 189, 13, 1),
                                  child: Text(
                                    'Back',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20,fontFamily: "Gruppo",fontWeight: FontWeight.bold),
                                  ),
                                ),

                                RaisedButton(
                                  padding: EdgeInsets.fromLTRB(30, 7, 30, 7),
                                  onPressed: () {
                                    print('Signed up');
                                    auth.createUserWithEmailAndPassword(email: usernameCon.text.trim(), password: passwordCon.text.trim());
                                    FirebaseFirestore.instance.collection(auth.currentUser.uid).doc("userdata").set(
                                        {
                                          "age":"Enter Age",
                                          "gender":"Enter Gender"
                                        });
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Homepage()));

                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  color: Color.fromRGBO(250, 189, 13, 1),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20,fontFamily: "Gruppo",fontWeight: FontWeight.bold),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

          ),
        ),
      ),
    );
  }
}

