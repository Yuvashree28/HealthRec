import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:healthrec/pages/LoginPage.dart';
import 'package:intl/intl.dart';
import 'Homepage.dart';
import 'package:mailer/mailer.dart' as m1;
import 'package:mailer2/mailer.dart' ;
import 'package:healthrec/services/AuthCheck.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  var _namevalue = "username";
  var _emailvalue = "email";
  var _agevalue = "age";
  var _gendervalue = "gender";

  int count = 0;
  double bodytemperatureavg=0;
  int bloodpressureavg=0;
  int respirationavg=0;
  int glucoseavg=0;
  int heartrateavg=0;
  int cholesterolavg=0;
  int oxygensaturationavg=0;
  int stepswalked;
  String age;
  String gender;
  FToast fToast;
  Icon icon;
  Color color;
  String ourfile ;


  var myFormat = DateFormat('d-MM-yyyy');


  TextEditingController _name;
  TextEditingController _email;
  TextEditingController _age;
  TextEditingController _gender;




  @override
  initState(){
    _name = new TextEditingController();
    _email = new TextEditingController();
    _age = new TextEditingController();
    _gender = new TextEditingController();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }
  DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);


  sendMail()  async {
    // String email = 'wellnesstracker7@gmail.com';
    // String password = 'trackerwellness*7';

    var options = new GmailSmtpOptions()
      ..username = 'healthrec24x7@gmail.com'
      ..password =  'rechealth247';


    // ignore: deprecated_member_use
    // final smtpServer = gmail(email, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.
    // Create our message.
    var emailTransport = new SmtpTransport(options);

    var envelope = new Envelope()
    // final message = m1.Message()
      ..from = 'healthrec24x7@gmail.com'
      ..recipients.add(user.email)
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Daily Health Report ${myFormat.format(dateToday)}'
      ..attachments.add(Attachment(file: new File(ourfile)))
      ..html = "<h1>Health Report ${myFormat.format(dateToday)}</h1>"
          "<p1>Hi ${user.displayName}, Your Health Report for ${myFormat.format(dateToday)} is here.</p1>";

    // try {
    //   final sendReport = await m1.send(message, smtpServer);
    //
    //   print('Message sent: ' + sendReport.toString());
    // } on m1.MailerException catch (e) {
    //   print('Message not sent.');
    //   for (var p in e.problems) {
    //     print('Problem: ${p.code}: ${p.msg}');
    //   }
    // }

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
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: <pw.Widget>[
                    pw.Text("Diabetes Risk",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(
                        width: 5
                    ),
                    pw.Text(":",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(
                        width: 5
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
    FirebaseAuth user = FirebaseAuth.instance;
    if(user.currentUser.displayName!=null){
      _namevalue=user.currentUser.displayName;
    }else{
      _namevalue="Enter Name";

    }
    _emailvalue=user.currentUser.email;

    CollectionReference users = FirebaseFirestore.instance.collection(user.currentUser.uid);
    return FutureBuilder(
        future:users.doc("userdata").get(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasError) {
            _agevalue="Enter age";
            _gendervalue="Enter gender";
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            _agevalue="Enter age";
            _gendervalue="Enter gender";
          }
          if (snapshot.hasData){
            return Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color:Colors.black87,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height:25,),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(child: Text("Profile",style: TextStyle(color: Colors.white,fontSize: 60,fontFamily:"SeaweedScript"))),
                          ),
                          SizedBox(height:550,),
                          Container(
                            height: 20,
                            width: 20,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(140),
                              ),
                              color:Colors.black87,
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                              ),

                            ),
                          ),




                        ],
                      ),
                      Positioned(
                        top: 220,
                        right: 40,
                        child:  Container(
                          height: 50,
                          width:50,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam")),
                                  Text("",style: TextStyle(color: Colors.white,fontSize: 12,fontFamily:"Kufam")),
                                ],
                              )),
                            ),

                          ),
                        ),
                      ),


                      Positioned(
                        top: 290,
                        child:  Container(
                          height: 70,
                          width: 70,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 405,
                        right: 25,
                        child:  Container(
                          height: 50,
                          width: 50,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 470,
                        left: 25,
                        child:  Container(
                          height: 60,
                          width: 60,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 480,
                        left: 157,
                        child:  Container(
                          height: 40,
                          width: 40,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 200,
                        right: 175,
                        child:  Container(
                          height: 40,
                          width: 40,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 150,
                        right: 90,
                        child:  Container(
                          height: 70,
                          width: 70,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 330,
                        left: 360,
                        child:  Container(
                          height: 80,
                          width: 80,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 560,
                        left: 340,
                        child:  Container(
                          height: 65,
                          width: 65,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 395,
                        right: 370,
                        child:  Container(
                          height: 90,
                          width: 90,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 540,
                        right: 355,
                        child:  Container(
                          height: 45,
                          width: 45,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 610,
                        left: ((MediaQuery.of(context).size.width)/4)+20,
                        child:  Container(
                          height: 70,
                          width: 150,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.white70,
                            elevation: 8,
                            child: InkWell(
                              splashColor: Colors.black26,
                              onTap: () {
                                signOut();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LogInPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Center(child: Text("Logout",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily:"Kufam"))),
                              ),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 140,
                        left: 60,
                        child:  Container(
                          height: 120,
                          width: 250,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Name",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam")),
                                  Text(_namevalue,style: TextStyle(color: Colors.white,fontSize: 12,fontFamily:"Kufam")),
                                ],
                              )),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 270,
                        left: 40,
                        child:  Container(
                          height: 90,
                          width: 150,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Age",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam")),
                                  Text(snapshot.data["age"],style: TextStyle(color: Colors.white,fontSize: 12,fontFamily:"Kufam")),
                                ],
                              )),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 270,
                        left: 200,
                        child:  Container(
                          height: 90,
                          width: 150,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Gender",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam")),
                                  Text(snapshot.data["gender"],style: TextStyle(color: Colors.white,fontSize: 12,fontFamily:"Kufam")),
                                ],
                              )),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 370,
                        left: 80,
                        child:  Container(
                          height: 120,
                          width: 250,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("email",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam")),
                                  Text(_emailvalue,style: TextStyle(color: Colors.white,fontSize: 12,fontFamily:"Kufam")),
                                ],
                              )),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 520,
                        right: 40,
                        child:  Container(
                          height:50,
                          width: 50,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam")),
                                  Text("",style: TextStyle(color: Colors.white,fontSize: 12,fontFamily:"Kufam")),
                                ],
                              )),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 520,
                        left: 30,
                        child:  Container(
                          height: 70,
                          width: 150,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: InkWell(
                              splashColor: Colors.black26,
                              onTap: () {
                                showDialog(
                                    child:  Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: EdgeInsets.all(10),
                                      child: SingleChildScrollView(
                                        physics: AlwaysScrollableScrollPhysics(),
                                        child:  Stack(
                                          overflow: Overflow.visible,
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.75,
                                              height:400,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(25),
                                                  color: Colors.white70
                                              ),
                                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  TextField(
                                                    decoration: new InputDecoration(
                                                      hintText: "Name",
                                                    ),
                                                    controller: _name,
                                                  ),
                                                  TextField(
                                                    decoration: new InputDecoration(
                                                      hintText: "Age",
                                                    ),
                                                    controller: _age,
                                                  ),
                                                  TextField(
                                                    decoration: new InputDecoration(
                                                      hintText: "Gender",
                                                    ),
                                                    controller: _gender,
                                                  ),


                                                  FlatButton(
                                                    child: new Text("Save",style: TextStyle(fontSize: 20),),
                                                    onPressed: (){

                                                      setState((){
                                                        if(_name.text!=null)
                                                        {
                                                          this._namevalue = _name.text;
                                                          this._agevalue= _age.text;
                                                          this._gendervalue=_gender.text;
                                                        }
                                                      });
                                                      FirebaseAuth.instance.currentUser.updateProfile(
                                                        displayName: _namevalue,
                                                      );

                                                      firestoreInstance.collection(user.currentUser.uid).doc("userdata").set(
                                                          {
                                                            "age":_agevalue,
                                                            "gender":_gendervalue
                                                          });
                                                      FirebaseAuth.instance.currentUser.reload();

                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),

                                    ), context: context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(child: Text("Edit",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam"))),
                              ),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 520,
                        left: 190,
                        child:  Container(
                          height: 70,
                          width: 200,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: InkWell(
                              splashColor: Colors.black26,
                              onTap: () {
                                firestoreInstance.collection("users").where("uid",isEqualTo: user.currentUser.uid).where("date",isEqualTo:myFormat.format(dateToday)).get().then((QuerySnapshot querySnapshot) => {
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


                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(child: Text("Send Report",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam"))),
                              ),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        left: 10,
                        child:  Container(
                          height: 70,
                          width: 70,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(140),
                            ),
                            color:Colors.black87,
                            elevation: 8,
                            child: InkWell(
                              splashColor: Colors.black26,
                              onTap: () {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Homepage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(child: Text("Back",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily:"Kufam"))),
                              ),
                            ),

                          ),
                        ),
                      ),

                    ],

                  ),
                ),
              ),
            );

    }
          return  Center(child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
          ));

          });

    // return Scaffold(
    //   body: Container(
    //     height: MediaQuery.of(context).size.height,
    //     width: MediaQuery.of(context).size.width,
    //     color:Colors.black87,
    //     child: SingleChildScrollView(
    //       physics: AlwaysScrollableScrollPhysics(),
    //       child: Stack(
    //         children: <Widget>[
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: <Widget>[
    //               SizedBox(height:25,),
    //               Padding(
    //                 padding: const EdgeInsets.all(20),
    //                 child: Center(child: Text("Profile",style: TextStyle(color: Colors.white,fontSize: 60,fontFamily:"SeaweedScript"))),
    //               ),
    //               SizedBox(height:550,),
    //               Container(
    //                 height: 20,
    //                 width: 20,
    //                 child: Card(
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(140),
    //                   ),
    //                   color:Colors.black87,
    //                   elevation: 8,
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(10),
    //                     child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
    //                   ),
    //
    //                 ),
    //               ),
    //
    //
    //
    //
    //             ],
    //           ),
    //           Positioned(
    //             top: 220,
    //             right: 40,
    //             child:  Container(
    //               height: 50,
    //               width:50,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(20),
    //                   child: Center(child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: <Widget>[
    //                       Text("",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam")),
    //                       Text("",style: TextStyle(color: Colors.white,fontSize: 12,fontFamily:"Kufam")),
    //                     ],
    //                   )),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //
    //
    //           Positioned(
    //             top: 290,
    //             child:  Container(
    //               height: 70,
    //               width: 70,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 405,
    //             right: 25,
    //             child:  Container(
    //               height: 50,
    //               width: 50,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 470,
    //             left: 25,
    //             child:  Container(
    //               height: 60,
    //               width: 60,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 480,
    //             left: 157,
    //             child:  Container(
    //               height: 40,
    //               width: 40,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 200,
    //             right: 175,
    //             child:  Container(
    //               height: 40,
    //               width: 40,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 150,
    //             right: 90,
    //             child:  Container(
    //               height: 70,
    //               width: 70,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 330,
    //             left: 360,
    //             child:  Container(
    //               height: 80,
    //               width: 80,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 560,
    //             left: 340,
    //             child:  Container(
    //               height: 65,
    //               width: 65,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 395,
    //             right: 370,
    //             child:  Container(
    //               height: 90,
    //               width: 90,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 540,
    //             right: 355,
    //             child:  Container(
    //               height: 45,
    //               width: 45,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Center(child: Text("",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:"Kufam"))),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 510,
    //             right: 90,
    //             child:  Container(
    //               height: 70,
    //               width: 150,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.white70,
    //                 elevation: 8,
    //                 child: InkWell(
    //                   splashColor: Colors.black26,
    //                   onTap: () {
    //                     signOut();
    //                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LogInPage()));
    //                   },
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(5),
    //                     child: Center(child: Text("Logout",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily:"Kufam"))),
    //                   ),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 140,
    //             left: 20,
    //             child:  Container(
    //               height: 120,
    //               width: 250,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(20),
    //                   child: Center(child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: <Widget>[
    //                       Text("Name",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam")),
    //                       Text(_namevalue,style: TextStyle(color: Colors.white,fontSize: 12,fontFamily:"Kufam")),
    //                     ],
    //                   )),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 280,
    //             left: 80,
    //             child:  Container(
    //               height: 120,
    //               width: 250,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(20),
    //                   child: Center(child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: <Widget>[
    //                       Text("email",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam")),
    //                       Text(_emailvalue,style: TextStyle(color: Colors.white,fontSize: 12,fontFamily:"Kufam")),
    //                     ],
    //                   )),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 425,
    //             right: 40,
    //             child:  Container(
    //               height:50,
    //               width: 50,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(20),
    //                   child: Center(child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: <Widget>[
    //                       Text("",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam")),
    //                       Text("",style: TextStyle(color: Colors.white,fontSize: 12,fontFamily:"Kufam")),
    //                     ],
    //                   )),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 420,
    //             left: 90,
    //             child:  Container(
    //               height: 70,
    //               width: 150,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: InkWell(
    //                   splashColor: Colors.black26,
    //                   onTap: () {
    //                     showDialog(
    //                         child:  Dialog(
    //                           backgroundColor: Colors.transparent,
    //                           insetPadding: EdgeInsets.all(10),
    //                           child: SingleChildScrollView(
    //                             physics: AlwaysScrollableScrollPhysics(),
    //                             child:  Stack(
    //                               overflow: Overflow.visible,
    //                               alignment: Alignment.center,
    //                               children: <Widget>[
    //                                 Container(
    //                                   width: MediaQuery.of(context).size.width*0.75,
    //                                   height:200,
    //                                   decoration: BoxDecoration(
    //                                       borderRadius: BorderRadius.circular(25),
    //                                       color: Colors.white70
    //                                   ),
    //                                   padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
    //                                   child: Column(
    //                                     mainAxisAlignment: MainAxisAlignment.center,
    //                                     children: <Widget>[
    //                                       TextField(
    //                                         decoration: new InputDecoration(
    //                                           hintText: "Name",
    //                                         ),
    //                                         controller: _name,
    //                                       ),
    //
    //
    //                                       FlatButton(
    //                                         child: new Text("Save",style: TextStyle(fontSize: 20),),
    //                                         onPressed: (){
    //
    //                                           setState((){
    //                                             if(_name.text!=null)
    //                                             {
    //                                               this._namevalue = _name.text;
    //                                             }
    //                                           });
    //                                           FirebaseAuth.instance.currentUser.updateProfile(
    //                                             displayName: _namevalue,
    //                                           );
    //                                           FirebaseAuth.instance.currentUser.reload();
    //
    //                                           Navigator.pop(context);
    //                                         },
    //                                       )
    //                                     ],
    //                                   ),
    //                                 ),
    //
    //                               ],
    //                             ),
    //                           ),
    //
    //                         ), context: context);
    //                   },
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(10),
    //                     child: Center(child: Text("Edit",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Kufam"))),
    //                   ),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 70,
    //             left: 10,
    //             child:  Container(
    //               height: 70,
    //               width: 70,
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(140),
    //                 ),
    //                 color:Colors.black87,
    //                 elevation: 8,
    //                 child: InkWell(
    //                   splashColor: Colors.black26,
    //                   onTap: () {
    //                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Homepage()));
    //                   },
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(10),
    //                     child: Center(child: Text("Back",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily:"Kufam"))),
    //                   ),
    //                 ),
    //
    //               ),
    //             ),
    //           ),
    //
    //         ],
    //
    //       ),
    //     ),
    //   ),
    // );
  }
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch (e){
    print(e.toString());
    return null;
    }
  }
}

