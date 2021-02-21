import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';

class ManRec extends StatefulWidget {
  @override
  _ManRecState createState() => _ManRecState();
}

class _ManRecState extends State<ManRec> {

  double _bodytemperaturevalue;
  int _bloodpressurevalue;
  int _respirationvalue;
  int _glucosevalue ;
  int _heartratevalue ;
  int _cholesterolvalue ;
  int _oxygensaturationvalue ;

  bool normalperson = true;
  bool acuteasthmapatient = false;
  bool hypoxemiapatient=false;
  bool chdpatient=false;
  bool bronchiectasispatient=false;
  bool prediabetespatient=false;
  bool diabetespatient=false;


  TextEditingController _bodytemperaturecont;
  TextEditingController _bloodpressurecont;
  TextEditingController _respirationcont;
  TextEditingController _glucosecont;
  TextEditingController _heartratecont;
  TextEditingController _cholesterolcont;
  TextEditingController _oxygensaturationcont;

  @override
  initState(){
    _bodytemperaturecont = new TextEditingController();
    _bloodpressurecont = new TextEditingController();
    _respirationcont = new TextEditingController();
    _glucosecont = new TextEditingController();
    _heartratecont = new TextEditingController();
    _cholesterolcont = new TextEditingController();
    _oxygensaturationcont = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(22, 14, 38, 1),
        leading: FlatButton(
          onPressed: () {
            print('back');
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Homepage()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white54,
          ),
        ),
        title: Text(
          'Manual Data Parser',
          style: TextStyle(
              fontFamily: 'SeaweedScript',
              color: Colors.white,
              fontSize: 30,
              ),
        ),
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(44, 29, 72, 1),
        child:  SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child:  Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color:Color.fromRGBO(22, 14, 32, 1),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Body Temperature", style: TextStyle(color:Colors.white,fontSize: 20,fontFamily:"Kufam"),
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white,fontFamily:"Kufam",fontSize: 13),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Enter body temperature",
                            hintStyle: TextStyle(color:Colors.white54,fontFamily:"Kufam",fontSize: 13)
                          ),
                          controller: _bodytemperaturecont,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 5),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color:Color.fromRGBO(22, 14, 32, 1),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Blood Pressure", style: TextStyle(color:Colors.white,fontSize: 20,fontFamily:"Kufam"),
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white,fontFamily:"Kufam",fontSize: 13),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Enter blood pressure value",
                              hintStyle: TextStyle(color:Colors.white54,fontFamily:"Kufam",fontSize: 13)
                          ),
                          controller: _bloodpressurecont,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color:Color.fromRGBO(22, 14, 32, 1),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Respiration", style: TextStyle(fontSize: 20,color:Colors.white,fontFamily:"Kufam"),
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white,fontFamily:"Kufam",fontSize: 13),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Enter respiration value",
                              hintStyle: TextStyle(fontFamily:"Kufam",color:Colors.white54,fontSize: 13)
                          ),
                          controller: _respirationcont,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color:Color.fromRGBO(22, 14, 32, 1),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Glucose", style: TextStyle(fontSize: 20,color:Colors.white,fontFamily:"Kufam"),
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white,fontFamily:"Kufam",fontSize: 13),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Enter glucose value",
                              hintStyle: TextStyle(fontFamily:"Kufam",color:Colors.white54,fontSize: 13)
                          ),
                          controller: _glucosecont,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color:Color.fromRGBO(22, 14, 32, 1),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Heart Rate", style: TextStyle(fontSize: 20,color:Colors.white,fontFamily:"Kufam"),
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white,fontFamily:"Kufam",fontSize: 13),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Enter heart rate",
                              hintStyle: TextStyle(fontFamily:"Kufam",color:Colors.white54,fontSize: 13)
                          ),
                          controller: _heartratecont,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color:Color.fromRGBO(22, 14, 32, 1),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Cholesterol", style: TextStyle(fontSize: 20,color:Colors.white,fontFamily:"Kufam"),
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white,fontFamily:"Kufam",fontSize: 13),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Enter cholesterol value",
                              hintStyle: TextStyle(fontFamily:"Kufam",color:Colors.white54,fontSize: 13)
                          ),
                          controller: _cholesterolcont,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color:Color.fromRGBO(22, 14, 32, 1),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Oxygen Saturation", style: TextStyle(fontSize: 20,color:Colors.white,fontFamily:"Kufam"),
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white,fontFamily:"Kufam",fontSize: 13),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Enter oxygen saturation value",
                              hintStyle: TextStyle(fontFamily:"Kufam",color:Colors.white54,fontSize: 13)
                          ),
                          controller: _oxygensaturationcont,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white70,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: new Text("Test",style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kufam')),
                      ),
                      onPressed: (){
                        setState((){
                          this._bodytemperaturevalue = double.parse(_bodytemperaturecont.text);
                          this._bloodpressurevalue = int.parse(_bloodpressurecont.text);
                          this._respirationvalue = int.parse(_respirationcont.text);
                          this._glucosevalue = int.parse(_glucosecont.text);
                          this._heartratevalue = int.parse(_heartratecont.text);
                          this._cholesterolvalue = int.parse(_cholesterolcont.text);
                          this._oxygensaturationvalue = int.parse(_oxygensaturationcont.text);
                        });
                        if(_respirationvalue>=20 && _respirationvalue<=30 && _oxygensaturationvalue>=92 && _oxygensaturationvalue<=95)
                        {
                          acuteasthmapatient =true;
                          normalperson=false;
                        }
                        if(_oxygensaturationvalue>=50 && _oxygensaturationvalue<=91)
                        {
                          hypoxemiapatient =true;
                          normalperson=false;
                        }
                        if(_heartratevalue>=45 && _heartratevalue<=60 && _cholesterolvalue>=200 && _cholesterolvalue<=270)
                        {
                          chdpatient =true;
                          normalperson=false;
                        }
                        if(_respirationvalue>=40 && _respirationvalue<=60)
                        {
                          bronchiectasispatient =true;
                          normalperson=false;
                        }
                        if(_glucosevalue>=140 && _glucosevalue<=199)
                        {
                          prediabetespatient =true;
                          normalperson=false;
                        }
                        if(_glucosevalue>=200){
                          diabetespatient =true;
                          normalperson=false;
                        };
                        showDialog(
                            child:Dialog(
                              backgroundColor: Colors.transparent,
                              insetPadding: EdgeInsets.all(10),
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.75,
                                  height:200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.black87
                                  ),
                                  padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      if(normalperson)...[
                                        Text("The person is",style: TextStyle(color: Colors.white)),
                                        Text("NORMAL",style: TextStyle(color: Colors.green),)],
                                      if(normalperson==false)
                                        Text("The person is diagnosed with",style: TextStyle(color: Colors.white)),
                                      SizedBox(height: 20,),
                                      if(acuteasthmapatient)
                                        Text("ACUTE ASTHMA",style: TextStyle(color: Colors.red)),
                                      if(hypoxemiapatient)
                                        Text("HYPOXEMIA",style: TextStyle(color: Colors.red)),
                                      if(chdpatient)
                                        Text("CONGENITAL HEART DEFECT",style: TextStyle(color: Colors.red)),
                                      if(bronchiectasispatient)
                                        Text("BRONCHIECTASIS",style: TextStyle(color: Colors.red)),
                                      if(prediabetespatient)
                                        Text("PREDIABETES",style: TextStyle(color: Colors.red)),
                                      if(diabetespatient)
                                        Text("DIABETES",style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ),
                            ),context: context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
