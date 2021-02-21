import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Record1.dart';
import 'Record2.dart';
import 'Record3.dart';
import 'Record4.dart';
import 'Record5.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:Color.fromRGBO(27, 89, 181, 1),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(

                      height: (MediaQuery.of(context).size.height/2.5)-60,
                      width: MediaQuery.of(context).size.width ,
                      child: Card(

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color:Color.fromRGBO(234, 243, 247, 1),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(35),
                          child: Center(child: Text("User's Health Record",style: TextStyle(color: Colors.black87,fontSize: 60,fontWeight:FontWeight.bold,fontFamily:"SeaweedScript"))),
                        ),
                      ),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height/4)-50,
                      width: MediaQuery.of(context).size.width ,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color:Colors.black87,

                        elevation: 8,
                        child: new InkWell(
                          splashColor: Colors.black26,
                          onTap: () async {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Record1()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(child: Text("Divya",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                                Divider(
                                  height: 20,
                                  thickness: .5,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.white70,
                                ),
                                SizedBox(height: 5,),
                                Center(
                                    child: Text(
                                        "Age: 21    Height: 146cm   Weight: 60kg    Gender: Male",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontFamily:"Kufam")
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),

                      ),
                    ),

                    Container(
                      height: (MediaQuery.of(context).size.height/4)-50,
                      width: MediaQuery.of(context).size.width ,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color:Colors.black87,

                        elevation: 8,
                        child: new InkWell(
                          splashColor: Colors.black26,
                          onTap: () async {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Record2()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(child: Text("Kirthika",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                                Divider(
                                  height: 20,
                                  thickness: .5,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.white70,
                                ),
                                SizedBox(height: 5,),
                                Center(
                                    child: Text(
                                        "Age: 21    Height: 150cm   Weight: 55kg    Gender: Female",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontFamily:"Kufam")
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),

                      ),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height/4)-50,
                      width: MediaQuery.of(context).size.width ,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color:Colors.black87,

                        elevation: 8,
                        child: new InkWell(
                          splashColor: Colors.white,
                          onTap: () async {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Record3()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(child: Text("Keerthi",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                                Divider(
                                  height: 20,
                                  thickness: .5,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.white70,
                                ),
                                SizedBox(height: 5,),
                                Center(
                                    child: Text(
                                        "Age: 20    Height: 135cm   Weight: 65kg    Gender: Female",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontFamily:"Kufam")
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),

                      ),
                    ),

                    Container(
                      height: (MediaQuery.of(context).size.height/4)-50,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color:Colors.black87,
                        elevation: 8,
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () async {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Record4()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Center(child: Text("Pryanga",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                                Divider(
                                  height: 20,
                                  thickness: .5,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.white70,
                                ),
                                SizedBox(height: 5,),
                                Center(
                                    child: Text(
                                        "Age: 19    Height: 150cm   Weight: 56kg    Gender: Female",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontFamily:"Kufam")
                                    )
                                ),
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height/4)-50,
                      width: MediaQuery.of(context).size.width ,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color:Colors.black87,
                        elevation: 8,
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () async {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Record5()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Center(child: Text("Thenmozhi",style: TextStyle(color: Colors.white,fontSize:25,fontFamily:"Kufam"))),
                                Divider(
                                  height: 20,
                                  thickness: .5,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.white70,
                                ),
                                SizedBox(height: 5,),
                                Center(
                                    child: Text(
                                        "Age: 22   Height: 136cm   Weight: 62kg    Gender: Female",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontFamily:"Kufam")
                                    )
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}
