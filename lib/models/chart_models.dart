import 'dart:convert';

import 'package:hexcolor/hexcolor.dart';

List<LastNScorecards> lastNScorecardsFromJson(String str) => List<LastNScorecards>.from(json.decode(str).map((x) => LastNScorecards.fromJson(x)));

String lastNScorecardsToJson(List<LastNScorecards> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LastNScorecards {
  String hcp;
  String rounds;
  String avgScore;
  double avgPutt;
  String fairway;
  String gir;
  String girTrend;
  String puttTrend;
  String shortGameTrend;
  String longGameTrend;

  LastNScorecards({
    required this.hcp,
    required this.rounds,
    required this.avgScore,
    required this.avgPutt,
    required this.fairway,
    required this.gir,
    required this.girTrend,
    required this.puttTrend,
    required this.shortGameTrend,
    required this.longGameTrend,
  });

  factory LastNScorecards.fromJson(Map<String, dynamic> json) => LastNScorecards(
    hcp: json["hcp"],
    rounds: json["rounds"],
    avgScore: json["avg_score"],
    avgPutt: json["avg_putt"],
    fairway: json["fairway"],
    gir: json["gir"],
    girTrend: json["gir_trend"],
    puttTrend: json["putt_trend"],
    shortGameTrend: json["short_game_trend"],
    longGameTrend: json["long_game_trend"],
  );

  Map<String, dynamic> toJson() => {
    "hcp": hcp,
    "rounds": rounds,
    "avg_score": avgScore,
    "avg_putt": avgPutt,
    "fairway": fairway,
    "gir": gir,
    "gir_trend": girTrend,
    "putt_trend": puttTrend,
    "short_game_trend": shortGameTrend,
    "long_game_trend": longGameTrend,
  };
}


List<ScorecardsModel> scorecardsModelFromJson(String str) => List<ScorecardsModel>.from(json.decode(str).map((x) => ScorecardsModel.fromJson(x)));

String scorecardsModelToJson(List<ScorecardsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScorecardsModel {
  String strokes;
  String courseName;
  DateTime startTime;
  String score;
  String cardId;

  ScorecardsModel({
    required this.strokes,
    required this.courseName,
    required this.startTime,
    required this.score,
    required this.cardId,
  });

  factory ScorecardsModel.fromJson(Map<String, dynamic> json) => ScorecardsModel(
    strokes: json["strokes"],
    courseName: json["courseName"],
    startTime: DateTime.parse(json["startTime"]),
    score: json["Score"],
    cardId: json["card_id"],
  );

  Map<String, dynamic> toJson() => {
    "strokes": strokes,
    "courseName": courseName,
    "startTime": "${startTime.year.toString().padLeft(4, '0')}-${startTime.month.toString().padLeft(2, '0')}-${startTime.day.toString().padLeft(2, '0')}",
    "Score": score,
    "card_id": cardId,
  };
}


List<CardModel> cardModelFromJson(String str) => List<CardModel>.from(json.decode(str).map((x) => CardModel.fromJson(x)));

String cardModelToJson(List<CardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardModel {
  var the1;
  var the2;
  var the3;
  var the4;
  var the5;
  var the6;
  var the7;
  var the8;
  var the9;
  var the10;
  var the11;
  var the12;
  var the13;
  var the14;
  var the15;
  var the16;
  var the17;
  var the18;
  String empty;
  dynamic? cardModelIn;
  dynamic? out;

  CardModel({
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the7,
    this.the8,
    this.the9,
    this.the10,
    this.the11,
    this.the12,
    this.the13,
    this.the14,
    this.the15,
    this.the16,
    this.the17,
    this.the18,
    required this.empty,
    this.cardModelIn,
    this.out,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    the1: json["1"] == null ? null : json["1"],
    the2: json["2"] == null ? null : json["2"],
    the3: json["3"] == null ? null : json["3"],
    the4: json["4"] == null ? null : json["4"],
    the5: json["5"] == null ? null : json["5"],
    the6: json["6"] == null ? null : json["6"],
    the7: json["7"] == null ? null : json["7"],
    the8: json["8"] == null ? null : json["8"],
    the9: json["9"] == null ? null : json["9"],
    the10: json["10"] == null ? null : json["10"],
    the11: json["11"] == null ? null : json["11"],
    the12: json["12"] == null ? null : json["12"],
    the13: json["13"] == null ? null : json["13"],
    the14: json["14"] == null ? null : json["14"],
    the15: json["15"] == null ? null : json["15"],
    the16: json["16"] == null ? null : json["16"],
    the17: json["17"] == null ? null : json["17"],
    the18: json["18"] == null ? null : json["18"],
    empty: json[""] == null ? null : json[""],
    cardModelIn: json["IN"] == null ? null : json["IN"],
    out: json["OUT"] == null ? null : json["OUT"],
  );

  Map<String, dynamic> toJson() => {
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": the5,
    "6": the6,
    "7": the7,
    "8": the8,
    "9": the9,
    "10": the10,
    "11": the11,
    "12": the12,
    "13": the13,
    "14": the14,
    "15": the15,
    "16": the16,
    "17": the17,
    "18": the18,
    "": empty,
    "IN": cardModelIn,
    "OUT": out,
  };
}


List<CardMapModel> cardMapModelFromJson(String str) => List<CardMapModel>.from(json.decode(str).map((x) => CardMapModel.fromJson(x)));

String cardMapModelToJson(List<CardMapModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardMapModel {
  String user;
  double gsStartLat;
  double gsEndLat;
  double gsStartLon;
  double gsEndLon;
  int gsShotOrder;
  String color;
  String gcDisplayName;
  int gsPlayerProfileId;
  int gsDistance;

  CardMapModel({
    required this.user,
    required this.gsStartLat,
    required this.gsEndLat,
    required this.gsStartLon,
    required this.gsEndLon,
    required this.gsShotOrder,
    required this.color,
    required this.gcDisplayName,
    required this.gsPlayerProfileId,
    required this.gsDistance,
  });

  CardMapModel copyWith({
    String? user,
    double? gsStartLat,
    double? gsEndLat,
    double? gsStartLon,
    double? gsEndLon,
    int? gsShotOrder,
    String? color,
    String? gcDisplayName,
    int? gsPlayerProfileId,
    int? gsDistance,
  }) =>
      CardMapModel(
        user: user ?? this.user,
        gsStartLat: gsStartLat ?? this.gsStartLat,
        gsEndLat: gsEndLat ?? this.gsEndLat,
        gsStartLon: gsStartLon ?? this.gsStartLon,
        gsEndLon: gsEndLon ?? this.gsEndLon,
        gsShotOrder: gsShotOrder ?? this.gsShotOrder,
        color: color ?? this.color,
        gcDisplayName: gcDisplayName ?? this.gcDisplayName,
        gsPlayerProfileId: gsPlayerProfileId ?? this.gsPlayerProfileId,
        gsDistance: gsDistance ?? this.gsDistance,
      );

  factory CardMapModel.fromJson(Map<String, dynamic> json) => CardMapModel(
    user: json["User"],
    gsStartLat: json["gs_start_lat"]?.toDouble(),
    gsEndLat: json["gs_end_lat"]?.toDouble(),
    gsStartLon: json["gs_start_lon"]?.toDouble(),
    gsEndLon: json["gs_end_lon"]?.toDouble(),
    gsShotOrder: json["gs_shot_order"],
    color: json["color"],
    gcDisplayName: json["gc_display_name"],
    gsPlayerProfileId: json["gs_playerProfileId"],
    gsDistance: json["gs_distance"],
  );

  Map<String, dynamic> toJson() => {
    "User": user,
    "gs_start_lat": gsStartLat,
    "gs_end_lat": gsEndLat,
    "gs_start_lon": gsStartLon,
    "gs_end_lon": gsEndLon,
    "gs_shot_order": gsShotOrder,
    "color": color,
    "gc_display_name": gcDisplayName,
    "gs_playerProfileId": gsPlayerProfileId,
    "gs_distance": gsDistance,
  };
}


List<TourModel> tourModelFromJson(String str) => List<TourModel>.from(json.decode(str).map((x) => TourModel.fromJson(x)));

String tourModelToJson(List<TourModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourModel {
  int id;
  String name;
  DateTime start;
  DateTime end;
  int members;

  TourModel({
    required this.id,
    required this.name,
    required this.start,
    required this.end,
    required this.members,
  });

  TourModel copyWith({
    int? id,
    String? name,
    DateTime? start,
    DateTime? end,
    int? members,
  }) =>
      TourModel(
        id: id ?? this.id,
        name: name ?? this.name,
        start: start ?? this.start,
        end: end ?? this.end,
        members: members ?? this.members,
      );

  factory TourModel.fromJson(Map<String, dynamic> json) => TourModel(
    id: json["id"],
    name: json["name"],
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
    members: json["members"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "start": "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
    "end": "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
    "members": members,
  };
}


List<TourLeaderboardModel> tourLeaderboardModelFromJson(String str) => List<TourLeaderboardModel>.from(json.decode(str).map((x) => TourLeaderboardModel.fromJson(x)));

String tourLeaderboardModelToJson(List<TourLeaderboardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourLeaderboardModel {
  int playerProfileId;
  int points;
  double pointsPerHole;
  String player;
  int eventsPlayed;

  TourLeaderboardModel({
    required this.playerProfileId,
    required this.points,
    required this.pointsPerHole,
    required this.player,
    required this.eventsPlayed,
  });

  TourLeaderboardModel copyWith({
    int? playerProfileId,
    int? points,
    double? pointsPerHole,
    String? player,
    int? eventsPlayed,
  }) =>
      TourLeaderboardModel(
        playerProfileId: playerProfileId ?? this.playerProfileId,
        points: points ?? this.points,
        pointsPerHole: pointsPerHole ?? this.pointsPerHole,
        player: player ?? this.player,
        eventsPlayed: eventsPlayed ?? this.eventsPlayed,
      );

  factory TourLeaderboardModel.fromJson(Map<String, dynamic> json) => TourLeaderboardModel(
    playerProfileId: json["playerProfileId"],
    points: json["Points"].toInt(),
    pointsPerHole: json["Points_per_Hole"]?.toDouble(),
    player: json["Player"],
    eventsPlayed: json["Events_Played"],
  );

  Map<String, dynamic> toJson() => {
    "playerProfileId": playerProfileId,
    "Points": points,
    "Points_per_Hole": pointsPerHole,
    "Player": player,
    "Events_Played": eventsPlayed,
  };
}

List<TourPlayers> tourPlayersFromJson(String str) => List<TourPlayers>.from(json.decode(str).map((x) => TourPlayers.fromJson(x)));

String tourPlayersToJson(List<TourPlayers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourPlayers {
  int playerProfileId;
  String name;

  TourPlayers({
    required this.playerProfileId,
    required this.name,
  });

  TourPlayers copyWith({
    int? playerProfileId,
    String? name,
  }) =>
      TourPlayers(
        playerProfileId: playerProfileId ?? this.playerProfileId,
        name: name ?? this.name,
      );

  factory TourPlayers.fromJson(Map<String, dynamic> json) => TourPlayers(
    playerProfileId: json["playerProfileId"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "playerProfileId": playerProfileId,
    "name": name,
  };
}


List<TourPlayersCardModel> tourPlayersCardModelFromJson(String str) => List<TourPlayersCardModel>.from(json.decode(str).map((x) => TourPlayersCardModel.fromJson(x)));

String tourPlayersCardModelToJson(List<TourPlayersCardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourPlayersCardModel {
  DateTime date;
  String courseName;
  String strokes;
  String score;
  double points;

  TourPlayersCardModel({
    required this.date,
    required this.courseName,
    required this.strokes,
    required this.score,
    required this.points,
  });

  TourPlayersCardModel copyWith({
    DateTime? date,
    String? courseName,
    String? strokes,
    String? score,
    double? points,
  }) =>
      TourPlayersCardModel(
        date: date ?? this.date,
        courseName: courseName ?? this.courseName,
        strokes: strokes ?? this.strokes,
        score: score ?? this.score,
        points: points ?? this.points,
      );

  factory TourPlayersCardModel.fromJson(Map<String, dynamic> json) =>
      TourPlayersCardModel(
        date: DateTime.parse(json["Date"]),
        courseName: json["Course Name"],
        strokes: json["Strokes"],
        score: json["Score"],
        points: json["Points"],
      );

  Map<String, dynamic> toJson() =>
      {
        "Date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString()
            .padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "Course Name": courseName,
        "Strokes": strokes,
        "Score": score,
        "Points": points,
      };

}


List<FriendsModel> friendsModelFromJson(String str) => List<FriendsModel>.from(json.decode(str).map((x) => FriendsModel.fromJson(x)));

String friendsModelToJson(List<FriendsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FriendsModel {
  int? id;
  String? name;

  FriendsModel({
    required this.id,
    required this.name,
  });

  FriendsModel copyWith({
    int? id,
    String? name,
  }) =>
      FriendsModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory FriendsModel.fromJson(Map<String, dynamic> json) => FriendsModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

List<TourInfo> tourInfoFromJson(String str) => List<TourInfo>.from(json.decode(str).map((x) => TourInfo.fromJson(x)));

String tourInfoToJson(List<TourInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourInfo {
  int id;
  String name;
  DateTime start;
  DateTime end;
  List<int> members;
  int minMembers;

  TourInfo({
    required this.id,
    required this.name,
    required this.start,
    required this.end,
    required this.members,
    required this.minMembers,
  });

  TourInfo copyWith({
    int? id,
    String? name,
    DateTime? start,
    DateTime? end,
    List<int>? members,
    int? minMembers,
  }) =>
      TourInfo(
        id: id ?? this.id,
        name: name ?? this.name,
        start: start ?? this.start,
        end: end ?? this.end,
        members: members ?? this.members,
        minMembers: minMembers ?? this.minMembers,
      );

  factory TourInfo.fromJson(Map<String, dynamic> json) => TourInfo(
    id: json["id"],
    name: json["name"],
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
    members: List<int>.from(json["members"].map((x) => x)),
    minMembers: json["min_members"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "start": "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
    "end": "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
    "members": List<dynamic>.from(members.map((x) => x)),
    "min_members": minMembers,
  };
}


List<LatestActivitiesModel> latestActivitiesModelFromJson(String str) => List<LatestActivitiesModel>.from(json.decode(str).map((x) => LatestActivitiesModel.fromJson(x)));

String latestActivitiesModelToJson(List<LatestActivitiesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LatestActivitiesModel {
  String player;
  DateTime date;
  String course;
  String score;

  LatestActivitiesModel({
    required this.player,
    required this.date,
    required this.course,
    required this.score,
  });

  LatestActivitiesModel copyWith({
    String? player,
    DateTime? date,
    String? course,
    String? score,
  }) =>
      LatestActivitiesModel(
        player: player ?? this.player,
        date: date ?? this.date,
        course: course ?? this.course,
        score: score ?? this.score,
      );

  factory LatestActivitiesModel.fromJson(Map<String, dynamic> json) => LatestActivitiesModel(
    player: json["Player"],
    date: DateTime.parse(json["Date"]),
    course: json["Course"],
    score: json["Score"],
  );

  Map<String, dynamic> toJson() => {
    "Player": player,
    "Date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "Course": course,
    "Score": score,
  };
}