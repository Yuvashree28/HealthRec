import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthrec/pages/Signuppage.dart';
import 'Homepage.dart';



class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  var _uname;
  var _pword;

  final unameC = new TextEditingController();
  final pwordC = new TextEditingController();
  FirebaseAuth fireauth = FirebaseAuth.instance;
  final _form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(45, 45, 47, 1),
        child: Form(
          key: _form_key,
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new RotatedBox(
                                quarterTurns: 3,
                                child: new Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 50,
                                      color: Color.fromRGBO(250, 189, 13, 1),
                                      fontFamily: "Gruppo"),
                                ),
                            ),

                            SizedBox(width: 30,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("HealthRec",style: TextStyle(color:Colors.white,fontSize: 50,fontFamily: "SeaweedScript",fontWeight: FontWeight.bold),),
                                Text("An application",style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: "Gruppo")),
                                Text("to assess your live",style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: "Gruppo"),),
                               // Text("your live",style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: "Gruppo"),),
                                Text("health data",style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: "Gruppo"),),
                                SizedBox(height: 20,),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Email',
                                        style: TextStyle(color: Colors.white, fontSize: 15),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 15,
                                        width: MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          controller: unameC,
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontFamily: 'OpenSans'),
                                          decoration: InputDecoration(

                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(top: 14.0),
                                            hintText: 'Enter email',
                                            hintStyle: TextStyle(
                                                color: Colors.white54, fontSize: 12),
                                            suffixIcon: Icon(Icons.perm_identity,
                                                color: Colors.white
                                              //color: Colors.black54,
                                            ),
                                          ),
                                          validator: (value) => value.isEmpty
                                              ? 'Email can\'t be empty'
                                              : null,
                                          onSaved: (value) => _uname = value.trim(),
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
                                        width: MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          controller: pwordC,
                                          obscureText: true,
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontFamily: 'OpenSans'),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(top: 14.0),
                                            hintText: 'Enter password',
                                            hintStyle: TextStyle(
                                                color: Colors.white54, fontSize: 12),
                                            suffixIcon:
                                            Icon(Icons.lock, color: Colors.white),
                                          ),
                                          validator: (value) => value.isEmpty
                                              ? 'Password can\'t be empty'
                                              : null,
                                          onSaved: (value) => _pword = value.trim(),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              padding: EdgeInsets.fromLTRB(30, 7, 30, 7),
                              onPressed: () async {
                                try{
                                  final user = await UserCheck.signInWithEmail(email: unameC.text.trim(),password: pwordC.text.trim());
                                  print(user);
                                  if(user!=null)
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage())) ;
                                  }
                                }catch(e){
                                  print(e);
                                  createAlertDialog(context);
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              color: Color.fromRGBO(250, 189, 13, 1),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20,fontFamily: "Gruppo",fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())) ;
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontFamily: 'Arimo'),
                              ),
                            )
                          ],
                        )

                      ],
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



createAlertDialog(BuildContext context) {
  TextEditingController customController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'User not Found',
                style: TextStyle(
                    color: Color.fromRGBO(159, 163, 167, 1),
                    fontFamily: 'Arimo',
                    fontSize: 14.5),
              ),
            ],
          ),
          elevation: 20.0,
          //backgroundColor: Color.fromRGBO(34, 45, 54, 1),
        );
      });
}



class UserCheck {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static signInWithEmail({String email, String password}) async {
    final res = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print(res);
    final User user = res.user;
    print(res.user);
    return user;
  }
}