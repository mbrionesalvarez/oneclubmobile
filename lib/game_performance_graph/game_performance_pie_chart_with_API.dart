import 'package:hexcolor/hexcolor.dart';
import 'package:oneclubmobile/network/network_helper.dart';
import 'package:oneclubmobile/game_performance_graph/game_performance_model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'game_performance_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedColumn100Chart extends StatefulWidget {
  /// Creates the stacked column 100 chart sample.
  // const StackedColumn100Chart({Key? key}) : super(key: key);
  const StackedColumn100Chart({Key? key}) : super(key: key);

  @override
  _StackedColumn100ChartState createState() => _StackedColumn100ChartState();
}

class _StackedColumn100ChartState extends State<StackedColumn100Chart> {
  List<GamePerformance> genders = [];
  bool loading = true;
  NetworkHelper _networkHelper = NetworkHelper();
  _StackedColumn100ChartState();

  // List<GamePerformance>? chartData;

  TooltipBehavior? _tooltipBehavior;

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

  // List<charts.Series<GamePerformance, int>> _createSampleData() {
  //   return [
  //     charts.Series<GamePerformance, int>(
  //       data: genders,
  //       id: 'sales',
  //       colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
  //       domainFn: (GamePerformance gamePerformance, _) => gamePerformance.holesBogeyTotal,
  //       measureFn: (GamePerformance gamePerformance, _) => gamePerformance.holesParTotal,
  //     )
  //   ];
  // }

  SfCartesianChart _buildStackedColumn100Chart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Game Performance'),
      legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.top
      ),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          rangePadding: ChartRangePadding.none,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getStackedColumnSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<ChartSeries<GamePerformance, String>> _getStackedColumnSeries() {
    return <ChartSeries<GamePerformance, String>>[
      StackedColumn100Series<GamePerformance, String>(
          dataSource: genders!,
          color: HexColor('#FCE300'),
          // dataLabelSettings: const DataLabelSettings(isVisible: true),
          xValueMapper: (GamePerformance sales, _) => sales.order,
          yValueMapper: (GamePerformance sales, _) => sales.holesUnderParTotal,
          name: 'Under Par'),
      StackedColumn100Series<GamePerformance, String>(
          dataSource: genders!,
          color: HexColor('#009B77'),
          // dataLabelSettings: const DataLabelSettings(isVisible: true),
          xValueMapper: (GamePerformance sales, _) => sales.order,
          yValueMapper: (GamePerformance sales, _) => sales.holesParTotal,
          name: 'Par'),
      StackedColumn100Series<GamePerformance, String>(
          dataSource: genders!,
          color: HexColor('#174038'),
          // dataLabelSettings: const DataLabelSettings(isVisible: true),
          xValueMapper: (GamePerformance sales, _) => sales.order,
          yValueMapper: (GamePerformance sales, _) => sales.holesBogeyTotal,
          name: 'Bogey'),
      StackedColumn100Series<GamePerformance, String>(
          dataSource: genders!,
          color: Colors.grey,
          // dataLabelSettings: const DataLabelSettings(isVisible: true),
          xValueMapper: (GamePerformance sales, _) => sales.order,
          yValueMapper: (GamePerformance sales, _) => sales.holesOverBogeyTotal,
          name: 'Over Bogey'),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Bar Chart With API"),
      // ),
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : Container(
          // height: 300,
          child: _buildStackedColumn100Chart(),

        ),
      ),
    );
  }
}