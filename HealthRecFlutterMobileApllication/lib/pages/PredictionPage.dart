import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthrec/services/httpservice.dart';

import 'Homepage.dart';

class Predict extends StatefulWidget {
  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  var glucose;
  var bp;
  final Prediction predict = Prediction();
  String diabetes;
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
          'Diabetes Prediction',
          style: TextStyle(
            fontFamily: 'SeaweedScript',
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: predict.getPrediction(119, 64),
        builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.hasData) {
        var prediction = snapshot.data;
        diabetes = prediction.diabetes.toString();
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(44, 29, 72, 1),
          child:  SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child:  Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color:Color.fromRGBO(22, 14, 32, 1),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.warning_rounded, color: Colors.white,
                          size: 33,),
                        title: const Text('Diabetes Risk',
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text(
                          prediction.diabetes.toString(),
                          style: TextStyle(color: Colors.white54),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );}
        return Center(child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
        ));
        }
      ),
    );
  }
}
