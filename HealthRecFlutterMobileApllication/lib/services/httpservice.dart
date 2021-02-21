import 'dart:convert';

import 'package:healthrec/models/DataJson.dart';
import 'package:healthrec/models/HealthRecPrediction.dart';
import 'package:http/http.dart';

class HttpService {
  final String healthrecUrl = "https://healthrec.herokuapp.com/api/normal";

  Future gethealthdata() async{
    final Response response = await get(healthrecUrl);
    var data = jsonDecode(response.body);



    // List<WellnessTracker> wellness = body.map((dynamic item) => WellnessTracker.fromJson(item)).toList();
    return HealthRec.fromJson(data);



  }
}


class Prediction {
  final String predictUrl = "http://192.168.1.6:8000/predictdiabetes";

  Future getPrediction(int glucose,int bp) async{
    final Response response = await get('$predictUrl?glucose=$glucose&bp=$bp');
    var data = jsonDecode(response.body);

    print("Predict API Called!!");
    print(response.body);
    print(DateTime.now().toString());
    return HealthRecPrediction.fromJson(data);
  }
}
