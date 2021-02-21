import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Record4 extends StatefulWidget {
  @override
  _Record4State createState() => _Record4State();
}

class _Record4State extends State<Record4> {
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
                          child: Center(child: Text("Divya",style: TextStyle(color: Colors.black87,fontSize: 60,fontWeight:FontWeight.bold,fontFamily:"SeaweedScript"))),
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
                            //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LiveRec()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(child: Text("Body Temperature",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
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
                                        "36.4 c",
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
                          splashColor: Colors.black26,
                          onTap: () async {
                            //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Predict()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(child: Text("Blood Pressure",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
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
                                        "114 mmHg",
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
                            //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ManRec()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(child: Text("Respiration",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
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
                                        "13 BPM",
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
                            //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HealthBot()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Center(child: Text("Glucose",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
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
                                        "92 mg/dL",
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
                            //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Profile()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Center(child: Text("Heart Rate",style: TextStyle(color: Colors.white,fontSize:25,fontFamily:"Kufam"))),
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
                                        "63 BPM",
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
                            //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Profile()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Center(child: Text("Cholesterol",style: TextStyle(color: Colors.white,fontSize:25,fontFamily:"Kufam"))),
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
                                        "130 mg/dL",
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
                            //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Profile()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Center(child: Text("Oxygen Saturation",style: TextStyle(color: Colors.white,fontSize:25,fontFamily:"Kufam"))),
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
                                        "95%",
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
