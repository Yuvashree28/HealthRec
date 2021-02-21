// To parse this JSON data, do
//
//     final healthRecPrediction = healthRecPredictionFromJson(jsonString);

import 'dart:convert';

HealthRecPrediction healthRecPredictionFromJson(String str) => HealthRecPrediction.fromJson(json.decode(str));

String healthRecPredictionToJson(HealthRecPrediction data) => json.encode(data.toJson());

class HealthRecPrediction {
  HealthRecPrediction({
    this.diabetes,
  });

  String diabetes;

  factory HealthRecPrediction.fromJson(Map<String, dynamic> json) => HealthRecPrediction(
    diabetes: json["diabetes"],
  );

  Map<String, dynamic> toJson() => {
    "diabetes": diabetes,
  };
}
