// To parse this JSON data, do
//
//     final gamePerformance = gamePerformanceFromJson(jsonString);

import 'dart:convert';

List<GamePerformance> gamePerformanceFromJson(String str) => List<GamePerformance>.from(json.decode(str).map((x) => GamePerformance.fromJson(x)));

String gamePerformanceToJson(List<GamePerformance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GamePerformance {
  int holesUnderParTotal;
  int holesParTotal;
  int holesBogeyTotal;
  int holesOverBogeyTotal;
  String order;

  GamePerformance({
    required this.holesUnderParTotal,
    required this.holesParTotal,
    required this.holesBogeyTotal,
    required this.holesOverBogeyTotal,
    required this.order,
  });

  factory GamePerformance.fromJson(Map<String, dynamic> json) => GamePerformance(
    holesUnderParTotal: json["holesUnderPar_total"],
    holesParTotal: json["holesPar_total"],
    holesBogeyTotal: json["holesBogey_total"],
    holesOverBogeyTotal: json["holesOverBogey_total"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "holesUnderPar_total": holesUnderParTotal,
    "holesPar_total": holesParTotal,
    "holesBogey_total": holesBogeyTotal,
    "holesOverBogey_total": holesOverBogeyTotal,
    "order": order,
  };
}