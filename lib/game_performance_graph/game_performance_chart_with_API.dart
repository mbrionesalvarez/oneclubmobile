import 'dart:ffi';

import 'package:oneclubmobile/network/network_helper.dart';
import 'package:oneclubmobile/game_performance_graph/game_performance_model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'game_performance_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class BarChartAPI extends StatefulWidget {
  const BarChartAPI({Key? key}) : super(key: key);

  @override
  State<BarChartAPI> createState() => _BarChartAPIState();
}

class _BarChartAPIState extends State<BarChartAPI> {
  List<GamePerformance> genders = [];
  bool loading = true;
  // NetWorkHelperParams _networkHelper = NetWorkHelperParams();

  @override
  void initState() {
    super.initState();
    getData();
  }


  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool CheckValue = prefs.containsKey('playerProfileId');
    // debugPrint(CheckValue);

    // String? player_id = prefs.getInt("playerProfileId");

    // debugPrint(player_id);
    // var response = await _networkHelper.get(
    //     '/api/landing/game_performance', {'playerProfileId': player_id});
    final uri = Uri.http('www.golfoneclub.com', '/api/landing/game_performance', {
      'playerProfileId': prefs.getInt('playerProfileId'),

    } .map((key, value) => MapEntry(key, value.toString())));
    http.Response response = await http.get(uri);
    debugPrint(response.body);
    List<GamePerformance> tempdata = gamePerformanceFromJson(response.body);
    setState(() {
      genders = tempdata;
      loading = false;
    });
  }

  List<charts.Series<GamePerformance, String>> _createSampleData() {
    return [
      charts.Series<GamePerformance, String>(
        data: genders,
        id: 'sales',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (GamePerformance gamePerformance, _) => gamePerformance.order,
        measureFn: (GamePerformance gamePerformance, _) => gamePerformance.holesOverBogeyTotal,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: loading
            ? CircularProgressIndicator()
            : Container(
          height: 300,
          child: charts.BarChart(
            _createSampleData(),
            animate: true,
          ),
        ),
      );

  }
}