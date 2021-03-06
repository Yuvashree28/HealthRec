import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart' as m1;
import 'package:healthrec/services/httpservice.dart';
import 'package:mailer2/mailer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'Homepage.dart';

import 'package:pdf/widgets.dart' as pw;

class LiveRec extends StatefulWidget {
  @override
  _LiveRecState createState() => _LiveRecState();
}

class _LiveRecState extends State<LiveRec> {

  final HttpService httpService = HttpService();
  final firestoreInstance = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  var myFormat = DateFormat('d-MM-yyyy');
  Timer _timer;
  int count = 0;
  double bodytemperatureavg=0;
  int bloodpressureavg=0;
  int respirationavg=0;
  int glucoseavg=0;
  int heartrateavg=0;
  int cholesterolavg=0;
  int oxygensaturationavg=0;
  int stepswalked;
  int countmail=0;
  FToast fToast;

  Icon icon;
  Color color;

  String ourfile ;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }


  DateTime dateToday = DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day);


  getdataperiodic(healthrec) {
    const oneSec = const Duration(seconds: 3600);

    new Timer.periodic(oneSec, (Timer t) =>
        firestoreInstance.collection("users").add(
            {
              "uid": user.uid,
              "date": myFormat.format(dateToday),
              "steps": healthrec.steps,
              "bodytemperature": healthrec.bodyTemperature,
              "bloodpressure": healthrec.bloodPressure,
              "respiration": healthrec.respiration,
              "glucose": healthrec.glucose,
              "heartrate": healthrec.heartRate,
              "cholesterol": healthrec.cholesterol,
              "oxygensaturation": healthrec.oxygenSaturation,

            }).then((value) {
          print(value.id);
        }));

  }

  sendMail()  async {

    var options = new GmailSmtpOptions()
      ..username = 'healthrec24x7@gmail.com'
      ..password =  'rechealth247';
    var emailTransport = new SmtpTransport(options);

    var envelope = new Envelope()
      ..from = 'healthrec24x7@gmail.com'
      ..recipients.add(user.email)
      ..subject = 'Daily Health Report ${myFormat.format(dateToday)}'
      ..attachments.add(Attachment(file: new File(ourfile)))
      ..html = "<h1>Health Report ${myFormat.format(dateToday)}</h1>"
          "<p1>Hi ${user.displayName}, Your Health Report for ${myFormat.format(dateToday)} is here.</p1>";


    emailTransport.send(envelope)
        .then((envelope) {
      print('Email sent!');
      EToast("Email Sent!");
    })
        .catchError((e) => print('Email Error occurred: $e'));

  }

  EToast(EToasttext) {
    if(EToasttext=="Sending Health Report"){
      icon=Icon(Icons.update);
    } else if(EToasttext=="Email Sent!"){
      icon=Icon(Icons.mail);
    }
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Text(EToasttext),
          icon,
          SizedBox(
            width: 12.0,
          ),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }


  Future<void> Pdfgenerator() async {
    final pdf = pw.Document();
    // final image = pw.MemoryImage(
    //   File('/storage/emulated/0/Android/data/com.example.wellnesstracker/files/pdflogo.png').readAsBytesSync(),
    // );
    final profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/logopdf.png')).buffer.asUint8List(),
    );


    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),

        build: (pw.Context context) => pw.Column(
            children:<pw.Widget> [
              pw.Image(profileImage),
              pw.Center(
                child: pw.Header(
                    level: 0,
                    child: pw.Text("Daily Health Report",style: pw.TextStyle(fontSize: 20,))
                ),
              ),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children:<pw.Widget>[
                          pw.Text("Name: ${user.displayName}"),
                          pw.SizedBox(
                              height: 5
                          ),
                          //pw.Text("Age: $age"),
                        ]
                    ),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children:<pw.Widget>[
                          pw.Text("Date: ${myFormat.format(dateToday)}"),
                          pw.SizedBox(
                              height: 5
                          ),
                          //pw.Text("Gender: $gender"),
                        ]
                    ),
                  ]
              ),
              pw.Divider(
                  thickness: 1
              ),

              pw.SizedBox(
                  height: 10
              ),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children:<pw.Widget>[
                    pw.Container(
                      //height: 20,
                      width: 140,
                      child:pw.Column(
                          children: <pw.Widget>[
                            pw.Text("Body Temperature",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(
                                height: 5
                            ),
                            pw.Text("${bodytemperatureavg}°C"),
                          ]
                      ),
                    ),

                    pw.Container(
                      //height: 20,
                      width: 140,
                      child:pw.Column(
                          children: <pw.Widget>[
                            pw.Text("Blood Pressure",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(
                                height: 5
                            ),
                            pw.Text("$bloodpressureavg mmHg"),
                          ]
                      ),
                    ),

                    pw.Container(
                      //height: 20,
                      width: 140,
                      child: pw.Column(
                          children: <pw.Widget>[
                            pw.Text("Respiration",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(
                                height: 5
                            ),
                            pw.Text("$respirationavg BPM"),
                          ]
                      ),
                    ),

                    pw.Container(
                      //height: 20,
                      width: 140,
                      child: pw.Column(
                          children: <pw.Widget>[
                            pw.Text("Glucose",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(
                                height: 5
                            ),
                            pw.Text("$glucoseavg mg/dL"),
                          ]
                      ),
                    ),

                  ]
              ),
              pw.SizedBox(
                  height: 10
              ),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children:<pw.Widget>[
                    pw.Container(
                      //height: 20,
                      width: 140,
                      child:pw.Column(
                          children: <pw.Widget>[
                            pw.Text("Heart Rate",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(
                                height: 5
                            ),
                            pw.Text("$heartrateavg BPM"),
                          ]
                      ),
                    ),

                    pw.Container(
                      //height: 20,
                      width: 140,
                      child: pw.Column(
                          children: <pw.Widget>[
                            pw.Text("Cholesterol",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(
                                height: 5
                            ),
                            pw.Text("$cholesterolavg mg/dL"),
                          ]
                      ),
                    ),

                    pw.Container(
                      //height: 20,
                      width: 140,
                      child: pw.Column(
                          children: <pw.Widget>[
                            pw.Text("Oxygen Saturation",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(
                                height: 5
                            ),
                            pw.Text("${oxygensaturationavg}%"),
                          ]
                      ),
                    ),

                  ]
              ),
              pw.SizedBox(
                  height: 10
              ),
              pw.Divider(
                  thickness: 1
              ),
              pw.SizedBox(
                  height: 10
              ),
              pw.SizedBox(
                  height: 10
              ),
              pw.Row(
                  children: <pw.Widget>[
                    pw.Text("Diabetes Risk",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(
                        height: 5
                    ),
                    pw.Text("Negative"),
                  ]
              ),
              pw.SizedBox(
                  height: 10
              ),
              pw.Divider(
                  thickness: 1
              ),
              pw.SizedBox(
                  height: 10
              ),


            ]


        ),
      ),
    );
    Directory appDocDir = await getExternalStorageDirectory();
    String appDocPath = appDocDir.path;
    final File ourfilex = File("$appDocPath/Healthreport ${myFormat.format(dateToday)}.pdf");
    print("File Location");
    print(ourfilex);
    await ourfilex.writeAsBytes(await pdf.save());
    ourfile=ourfilex.path.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Homepage()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white54,
          ),
        ),
        title: Text(
          '  Live Health Data',
          style: TextStyle(
            fontFamily: 'SeaweedScript',
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: httpService.gethealthdata(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
        var healthrec = snapshot.data;
        getdataperiodic(healthrec);
        _timer = new Timer.periodic(Duration(seconds: 60), (timer) {
          if (DateTime
              .now()
              .hour == 23 && DateTime
              .now()
              .minute == 59)  {
            countmail++;

            firestoreInstance.collection("users").where("uid",isEqualTo: user.uid).where("date",isEqualTo:myFormat.format(dateToday)).get().then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                bodytemperatureavg=bodytemperatureavg+doc["bodytemperature"];
                bloodpressureavg=bloodpressureavg+doc["bloodpressure"];
                respirationavg=respirationavg+doc["respiration"];
                glucoseavg=glucoseavg+doc["glucose"];
                heartrateavg=heartrateavg+doc["heartrate"];
                cholesterolavg=cholesterolavg+doc["cholesterol"];
                oxygensaturationavg=oxygensaturationavg+doc["oxygensaturation"];
                count++;

              }),
              {
                bodytemperatureavg=(bodytemperatureavg/count),
                bodytemperatureavg=double.parse(bodytemperatureavg.toStringAsFixed(1)),
                bloodpressureavg=(bloodpressureavg~/count),
                respirationavg=(respirationavg~/count),
                glucoseavg=(glucoseavg~/count),
                heartrateavg=(heartrateavg~/count),
                cholesterolavg=(cholesterolavg~/count),
                oxygensaturationavg=(oxygensaturationavg~/count),
                print('Average Body Temperature:$bodytemperatureavg'),
                print('Average Blood Pressure:$bloodpressureavg'),
                print('Average Respiration:$respirationavg'),
                print('Average Glucose:$glucoseavg'),
                print('Average Heart Rate:$heartrateavg'),
                print('Average Cholesterol:$cholesterolavg'),
                print('Average Oxygen Saturation:$oxygensaturationavg'),
                EToast("Sending Health Report"),
                Pdfgenerator(),
                sendMail(),
              },
              {
                firestoreInstance.collection("reports").add(
                    {
                      "uid": user.uid,
                      "date": myFormat.format(dateToday),
                      "bodytemperatureavg": bodytemperatureavg,
                      "bloodpressureavg": bloodpressureavg,
                      "respirationavg": respirationavg,
                      "glucoseavg":glucoseavg,
                      "heartrateavg":heartrateavg ,
                      "cholesterolavg":cholesterolavg,
                      "oxygensaturationavg": oxygensaturationavg,
                    }).then((value) {
                  print(value.id);
                })
              }


            });
            if(countmail==2)
              { _timer.cancel();}

          }
        });



        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width/2,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height/4,
                            child: Center(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white30,
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                    child: ListTile(
                                      title: const Text('Steps',
                                          style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Kufam")),
                                      subtitle: Text(
                                        healthrec.steps.toString(),
                                        style: TextStyle(color: Colors.white54,fontFamily: "Kufam"),
                                      ),
                                    ),
                                  ),

                                ]),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/4,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.black87,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                  child: ListTile(
                                    title: const Text('Body Temperature',
                                        style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Kufam")),
                                    subtitle: Text(
                                      healthrec.bodyTemperature.toString(),
                                      style: TextStyle(color: Colors.white54,fontFamily: "Kufam"),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/4,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white30,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                  child: ListTile(
                                    title: const Text('Respiration',
                                        style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Kufam")),
                                    subtitle: Text(
                                      healthrec.respiration.toString(),
                                      style: TextStyle(color: Colors.white54,fontFamily: "Kufam"),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/4,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.black87,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Padding(
                                      padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                      child:ListTile(
                                        title: const Text('Cholesterol',
                                            style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Kufam")),
                                        subtitle: Text(
                                          healthrec.cholesterol.toString(),
                                          style: TextStyle(color: Colors.white54,fontFamily: "Kufam"),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width/2,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height/4,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.black87,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [

                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                  child: ListTile(
                                    title: const Text('Heart Rate',
                                        style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Kufam")),
                                    subtitle: Text(
                                      healthrec.heartRate.toString(),
                                      style: TextStyle(color: Colors.white54,fontFamily: "Kufam"),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/4,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white30,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [

                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                  child: ListTile(
                                    title: const Text('Blood Pressure',
                                        style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Kufam")),
                                    subtitle: Text(
                                      healthrec.bloodPressure.toString(),
                                      style: TextStyle(color: Colors.white54,fontFamily: "Kufam"),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/4,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.black87,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [

                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                  child:  ListTile(
                                    title: const Text('Glucose',
                                        style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Kufam")),
                                    subtitle: Text(
                                      healthrec.glucose.toString(),
                                      style: TextStyle(color: Colors.white54,fontFamily: "Kufam"),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/4,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white30,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [

                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                  child: ListTile(
                                    title: const Text('Oxygen Saturation',
                                        style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Kufam")),
                                    subtitle: Text(
                                      healthrec.oxygenSaturation.toString(),
                                      style: TextStyle(color: Colors.white54,fontFamily: "Kufam"),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
    }
        return Center(child: CircularProgressIndicator());
    }),
    );

  }
}