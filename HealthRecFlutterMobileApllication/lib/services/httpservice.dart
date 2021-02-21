import 'dart:convert';

import 'package:healthrec/models/DataJson.dart';
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
