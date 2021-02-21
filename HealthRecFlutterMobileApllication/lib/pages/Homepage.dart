import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthrec/pages/LiveRec.dart';

import 'HeathBot.dart';
import 'ManRec.dart';
import 'Profile.dart';

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
                          child: Center(child: Text("HealthRec",style: TextStyle(color: Colors.black87,fontSize: 60,fontWeight:FontWeight.bold,fontFamily:"SeaweedScript"))),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height/4,
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
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LiveRec()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(child: Text("Live Record",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
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
                                        "Monitor your live health data and assess it",
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
                      height: MediaQuery.of(context).size.height/4,
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
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ManRec()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(child: Text("Manual Data",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
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
                                        "Feed your own data and assess your health",
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
                      height: MediaQuery.of(context).size.height/4,
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
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HealthBot()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Center(child: Text("HealthBot",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
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
                                        "Interact with HealthBot and get health tips",
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
                      height: MediaQuery.of(context).size.height/4,
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
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Profile()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Center(child: Text("Profile",style: TextStyle(color: Colors.white,fontSize:25,fontFamily:"Kufam"))),
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
                                        "User Profile",
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
                Positioned(
                    child: Icon(Icons.account_circle,color: Colors.blueAccent,size: 50,),
                  right: 20,
                  bottom: 127,
                ),
                Positioned(
                  child: Icon(Icons.phonelink_setup,color: Colors.blueAccent,size: 50,),
                  right: 20,
                  bottom: 297,
                ),
                Positioned(
                  child: Icon(Icons.message,color: Colors.blueAccent,size: 50,),
                  right: 20,
                  bottom: 468,
                ),
                Positioned(
                  child: Icon(Icons.watch,color: Colors.blueAccent,size: 50,),
                  right: 20,
                  bottom: 634,
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
