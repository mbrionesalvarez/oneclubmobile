import 'package:flutter/material.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:oneclubmobile/game_performance_graph/game_performance_chart_with_API.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oneclubmobile/game_performance_graph/game_performance_pie_chart_with_API.dart';
import 'package:oneclubmobile/views/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:oneclubmobile/models/chart_models.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:oneclubmobile/views/landing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oneclubmobile/models/chart_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoibWJyaW9uZXM5MyIsImEiOiJja29laWJ3aTYwNzBzMnBqem9sbTJwZngwIn0.g-QTGe2zDsaVZwPvTQUIzA';

const double MARKER_SIZE = 25;

class Scorecards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScorecards(title: '');

  }
}


class MyScorecards extends StatefulWidget {
  const MyScorecards({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyScorecards> createState() => _MyScorecards();
}

class _MyScorecards extends State<MyScorecards> {
  int _counter = 0;
  String name = '';


  @override
  void initState() {
    super.initState();
    _GetPerfs();

  }


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _GetPerfs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('name') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: HexColor("#174038"),
        automaticallyImplyLeading: false,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        // child:
        //     MapScreen(),

      ),
      bottomNavigationBar: BottomNavigationBar(

        items: const [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home)

          ),
          BottomNavigationBarItem(
              label: 'Scorecards',
              icon: Icon(Icons.scoreboard)
          ),
          BottomNavigationBarItem(
            label: 'More',
            icon: Icon(Icons.more_horiz, color: Colors.green,),


          ),
          // BottomNavigationBarItem(
          //     label: 'More',
          //     icon: Icon(Icons.more_horiz_sharp)
          // )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


// Widget titleSection = Container(
//   padding: const EdgeInsets.all(32),
//   child: Row(
//     children: [
//       Expanded(
//         /*1*/
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /*2*/
//             Container(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: const Text(
//                 '$name',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Text(
//               'Kandersteg, Switzerland',
//               style: TextStyle(
//                 color: Colors.grey[500],
//               ),
//             ),
//           ],
//         ),
//       ),
//       /*3*/
//       Icon(
//         Icons.star,
//         color: Colors.red[500],
//       ),
//       const Text('41'),
//     ],
//   ),
// );

// class titleSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(32),
//       child: Row(
//         children: [
//           Expanded(
//             /*1*/
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /*2*/
//                 Container(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: const Text(
//                     '',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   'Kandersteg, Switzerland',
//                   style: TextStyle(
//                     color: Colors.grey[500],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           /*3*/
//           Icon(
//             Icons.star,
//             color: Colors.red[500],
//           ),
//           const Text('41'),
//         ],
//       ),
//     );
//   }
// }


class UserInfo extends StatefulWidget {
  const UserInfo({super.key, required this.name});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String name;

  @override
  State<UserInfo> createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Container(
      padding: const EdgeInsets.all(32),
      color: HexColor("#009B77"),
      child: Row(

        children: [
          Expanded(
            /*1*/

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/

                  // padding: const EdgeInsets.only(bottom: 8),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: HexColor('#FCE300')
                    ),
                  ),

                // Text(
                //   'Kandersteg, Switzerland',
                //   style: TextStyle(
                //     color: Colors.grey[500],
                //   ),
                // ),
              ],
            ),
          ),
          /*3*/
          // Icon(
          //   Icons.star,
          //   color: Colors.red[500],
          // ),
          // const Text('41'),
          Expanded(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Hcp',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
              '16',
              style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              ),
              ),
              ),
              ],
              ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Rounds',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  '365',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}



class ScorecardMap extends StatefulWidget {
  const ScorecardMap({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<ScorecardMap> createState() => _ScorecardMap();
}

class _ScorecardMap extends State<ScorecardMap> {
  List<LastNScorecards> genders=[];
  bool loading = true;
  String name = '';

  @override
  void initState() {
    super.initState();
    getData();
    _GetPerfs();
  }


  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool CheckValue = prefs.containsKey('playerProfileId');
    // debugPrint(CheckValue);

    // String? player_id = prefs.getInt("playerProfileId");

    // debugPrint(player_id);
    // var response = await _networkHelper.get(
    //     '/api/landing/game_performance', {'playerProfileId': player_id});
    final uri = Uri.http('www.golfoneclub.com', '/api/landing/quick_analysis', {
      'playerProfileId': prefs.getInt('playerProfileId'),
      'unit': prefs.getString('unit'),

    } .map((key, value) => MapEntry(key, value.toString())));
    http.Response response = await http.get(uri);
    debugPrint(response.body);
    // var data = jsonDecode(response.body);
    List<LastNScorecards> tempdata = lastNScorecardsFromJson(response.body);
    setState(() {
      genders = tempdata;
      loading = false;
    });
    // print(data.runtimeType);
    // print(data.avg_score);
    debugPrint(genders.single.avgScore);
  }




  void _GetPerfs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('name') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Wrap( children:[
      Container(
        padding: const EdgeInsets.all(32),
        color: HexColor("#009B77"),
        child: Row(

          children: [
            Expanded(
              /*1*/

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*2*/
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: HexColor('#FCE300')
                      ),
                    ),
                  ),
                  // Text(
                  //   'Kandersteg, Switzerland',
                  //   style: TextStyle(
                  //     color: Colors.grey[500],
                  //   ),
                  // ),
                ],
              ),
            ),
            /*3*/
            // Icon(
            //   Icons.star,
            //   color: Colors.red[500],
            // ),
            // const Text('41'),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hcp',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      genders.single.hcp,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Rounds',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    genders.single.rounds,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      Container(
      padding: const EdgeInsets.all(32),
      child: Wrap(
    children: <Widget>[Row(children: [Expanded(
      /*1*/

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*2*/
          Container(
            // padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Last 10 rounds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          // Text(
          //   'Kandersteg, Switzerland',
          //   style: TextStyle(
          //     color: Colors.grey[500],
          //   ),
          // ),
        ],
      ),
    ),]),
      Row(
        children: [
          UserMetricsComponent(title: 'Strokes', value: genders.single.avgScore),
          UserMetricsComponent(title: 'GIR', value: genders.single.gir,),
          UserMetricsComponent(title: 'Fairway', value: genders.single.fairway,),
          UserMetricsComponent(title: 'Avg Putts', value: genders.single.avgPutt.toString(),)
        ],
      ),
      SizedBox(height:50),
      Row(
        children: [
          UserMetricsComponent(title: 'Approach', value: genders.single.girTrend,),
          UserMetricsComponent(title: 'Putt', value: genders.single.puttTrend,),
          UserMetricsComponent(title: 'Short Game', value: genders.single.shortGameTrend,),
          UserMetricsComponent(title: 'Long Game', value: genders.single.longGameTrend,)
        ],
      ),
    ]
      )
    )]
    );
  }
}

class UserMetricsComponent extends StatefulWidget {
  const UserMetricsComponent({super.key, required this.title, required this.value});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final title;
  final value;

  @override
  State<UserMetricsComponent> createState() => _UserMetricsComponent();
}

class _UserMetricsComponent extends State<UserMetricsComponent> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: HexColor('#174038'),
              )),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              widget.value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: HexColor('#174038'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavButtons extends StatefulWidget {
  const NavButtons({super.key, required this.name});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String name;

  @override
  State<NavButtons> createState() => _NavButtons();
}

class _NavButtons extends State<NavButtons> {

  @override
  Widget build(BuildContext context) {

    return Container(
      // height: 100,
      child: Expanded(

        child: GridView(children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: HexColor("#009B77"),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart_rounded,size: 50,color: Colors.white,),
                  Text("Stats",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: HexColor("#009B77"),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sports_golf_rounded,size: 50,color: Colors.white,),
                  Text("Bag",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),)
                ],),
              ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: HexColor("#009B77"),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people,size: 50,color: Colors.white,),
                  Text("Buddies",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: HexColor("#009B77"),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.golf_course_sharp,size: 50,color: Colors.white,),
                  Text("Courses",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                    fontWeight: FontWeight.bold),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: HexColor("#009B77"),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.tour,size: 50,color: Colors.white,),
                  Text("Tour",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: HexColor("#009B77"),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dataset_rounded,size: 50,color: Colors.white,),
                  Text("Data",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),)
                ],),
            ),
          ),
        ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 10,crossAxisSpacing: 10),
        ),
      ),);
  }
}

class NavButtonsComponent extends StatefulWidget {
  const NavButtonsComponent({super.key, required this.title, required this.icon});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final icon;

  @override
  State<NavButtonsComponent> createState() => _NavButtonsComponent();
}

class _NavButtonsComponent extends State<NavButtonsComponent> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(widget.icon, color: HexColor('#174038')),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: HexColor('#174038'),
            ),
          ),
        ),
      ],
    );

    //   Expanded(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text(widget.title,
    //           style: TextStyle(
    //             fontSize: 14,
    //             fontWeight: FontWeight.bold,
    //             color: HexColor('#174038'),
    //           )),
    //       Container(
    //         margin: const EdgeInsets.only(top: 8),
    //         child: Text(
    //           widget.value,
    //           style: TextStyle(
    //             fontSize: 12,
    //             fontWeight: FontWeight.bold,
    //             color: HexColor('#174038'),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      width: 200,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}




class MapScreen extends StatefulWidget {
  // const MapScreen({super.key});
  final id;
  final hole;
  MapScreen({Key? key, required this.id, required this.hole}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {
  // LatLng? myPosition;
  List<LatLng> points = [];
  List<CardMapModel> mapdata = [];
  var fields = [];
  List<ShotMarker> allMarkers = [];
  List<Polyline> allLines = [];
  LatLng? center;
  late MapController _mapController;
  final PopupController _popupLayerController = PopupController();
  bool swap = false;



  // List<CardModel> tempdata=[];
  // @override
  // void initState() {
  //   super.initState();
  //   // data = widget.datalist;
  //   employeeDataSource = EmployeeDataSource(data: widget.datalist);
  // }
  Future getData() async {
    allMarkers.clear();
    allLines.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // debugPrint(widget.id);
    final uri = Uri.http('www.golfoneclub.com', '/api/landing/card/map', {
      'playerProfileId': prefs.getInt('playerProfileId'),
      'card_id': widget.id,
      'hole': widget.hole
    }.map((key, value) => MapEntry(key, value.toString())));
    print(uri);
    http.Response response = await http.get(uri);
    // debugPrint(response.body);
    // print('Pepi');
    // List<CardModel> tempdata = cardModelFromJson(response.body);
    // jsonDataGridSource = _JsonDataGridSource(tempdata);
    // print(tempdata);
    // return tempdata;
    // var list = json.decode(response.body).cast<Map<String, dynamic>>();
    var datamodel = json.decode(response.body);
    var list = datamodel['data'].cast<Map<String, dynamic>>();
    print(list);
    mapdata =
    await list.map<CardMapModel>((json) => CardMapModel.fromJson(json))
        .toList();
    // print(list[0].keys);
    // jsonDataGridSource = _JsonDataGridSource(card);
    // fields = list[0].keys.toList();
    var avg_lat = list.map((m) => m['gs_start_lat']).reduce((a, b) => a + b) / list.length;
    var avg_lon = list.map((m) => m['gs_start_lon']).reduce((a, b) => a + b) / list.length;
    // print(avg_lat);
    // print(avg_lon);
    center = LatLng(
      avg_lat,
      avg_lon,
    );
    // _mapController.move(new LatLng(avg_lat, avg_lon), 17.0);
    // _mapController.move(LatLng(avg_lat, avg_lon), 18.0);

    if (widget.hole != 1 && swap == false) {
      swap = true;
    }
    if (swap == true) {
      _mapController.move(new LatLng(avg_lat, avg_lon), 17.0);
    }
    // print(center);
    String hexcolor;
    dynamic color;
    for (dynamic player in datamodel['users']) {
      // print(player);
      for (var i = 0; i < mapdata.length; i++) {
        // print(mapdata[i].gsStartLat);
        // print(player == mapdata[i].gsPlayerProfileId.toString());
        if (player == mapdata[i].gsPlayerProfileId.toString()) {
          LatLng latlng;
          latlng = LatLng(
            mapdata[i].gsStartLat,
            mapdata[i].gsStartLon,
          );
          // print(latlng);
          // String color;
          // var colordata = HexColor(mapdata[i].color);
          // var stringcolor;
          var color = mapdata[i].color;
          var hexcolor = '#' + color;
          // stringcolor = const _MyColor(hexcolor);
          // print(hexcolor);
          allMarkers.add(
              // Marker(
              //   point: latlng,
              //   builder: (context) {
              //     return Container(
              //       child: Icon(
              //         Icons.circle,
              //         color: HexColor(color),
              //         size: 20,
              //       ),
              //     );
              //   },
              // )

            ShotMarker(
                shot: Shot(
                number: mapdata[i].gsShotOrder,
                club:  mapdata[i].gcDisplayName,
                  distance: mapdata[i].gsDistance,
                  color: mapdata[i].color,
                  lat: mapdata[i].gsStartLat,
                  long: mapdata[i].gsStartLon,
                  name: mapdata[i].user,
                ),
          )
          );


          // allMarkers.add(
          //     Marker(
          //       point: latlng,
          //       builder: (context) {
          //         return Container(
          //           child: Icon(
          //             Icons.circle,
          //             color: HexColor(color),
          //             size: 20,
          //           ),
          //         );
          //       },
          //     )
          // );
          // allMarkers.add(Marker(
          //   point: latlng,
          //   width: 40,
          //   height: 40,
          //   builder: (_) =>  Icon(
          //       Icons.circle,
          //       color: HexColor(color),
          //       size: 20,
          //     ),
          //
          //   // anchorPos: const AnchorPos.align(AnchorAlign.top),
          //   rotateAlignment: AnchorAlign.top.rotationAlignment,
          // )
          // );
          points.add(latlng);
          // if (i == mapdata.length) {
          //   LatLng latlngend;
          //   latlngend = LatLng(
          //     mapdata[i].gsEndLat,
          //     mapdata[i].gsEndLon,
          //   );
          //   points.add(latlngend);
          // }
          // print(points);
          allLines.add(
              Polyline(
                // points: points,
                points: [LatLng(mapdata[i].gsStartLat, mapdata[i].gsStartLon), LatLng(mapdata[i].gsEndLat, mapdata[i].gsEndLon)],
                color: HexColor(color),

              )
          );
        }

      }
    }
    // print(allLines);
    return mapdata;

    // return mapdata;
    // setState(() {
    //   // jsonDataGridSource = tempdata;
    //   // loading = false;
    // });
  }


  // Future<Position> determinePosition() async {
  //   LocationPermission permission;
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('error');
  //     }
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }
  //
  // void getCurrentLocation() async {
  //   // Position position = await determinePosition();
  //
  //   setState(() {
  //     myPosition = LatLng(39.4237954, -6.3763427);
  //     points = [LatLng(39.4237954, -6.3763427), LatLng(39.4234554, -6.3763427)];
  //     print(myPosition);
  //   });
  // }



  @override
  void initState() {
    // getCurrentLocation();
    super.initState();
    // getData();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.hasData);
          print(center);
          // print(fields);
          return snapshot.hasData
              ? FlutterMap(
          // return FlutterMap(
            options: MapOptions(
                center: center,
                // minZoom: 5, maxZoom: 40,
                zoom: 17,
              // interactionOptions: const InteractionOptions(
              //   flags: InteractiveFlag.all,
              // ),
              onTap: (_, __) => _popupLayerController.hideAllPopups(),

            ),
            mapController: _mapController,

            children: [
              TileLayer(
                urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': 'mapbox/satellite-v9'
                },

              ),

              // MarkerLayer(
              //   markers: allMarkers
              //   // [
              //   //   Marker(
              //   //     point: myPosition!,
              //   //     builder: (context) {
              //   //       return Container(
              //   //         child: const Icon(
              //   //           Icons.circle,
              //   //           color: Colors.blueAccent,
              //   //           size: 20,
              //   //         ),
              //   //       );
              //   //     },
              //   //   )
              //   // ],
              // ),
              PolylineLayer(
                  polylines: allLines
                // [
                //   Polyline(
                //     points: points,
                //     color: Colors.blue,
                //   ),
                // ],
              ),
                  PopupMarkerLayer(
                  options: PopupMarkerLayerOptions(
                  markers: allMarkers,
                    // popupController: _popupLayerController,
                  popupDisplayOptions: PopupDisplayOptions(
                  builder: (BuildContext context, Marker marker) {
                    if (marker is ShotMarker) {
                      return ShotMarkerPopup(shot: marker.shot);
                    }
                    return Card(child: const Text('Not a monument'));
                  },
                  // ExamplePopup(marker),

                  ),
                    // selectedMarkerBuilder: (context, marker) => const Icon(
                    //   Icons.location_on,
                    //   size: 40,
                    //   color: Colors.red,
                    // ),
                  ),
                  ),

            ],
          )
              : Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
            // child: Text('Pollon'),
          );
          // return SfDataGrid(
          //     source: jsonDataGridSource,
          //     columns: getColumns()
          // );
        });
  }

}
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('1'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: myPosition == null
//           ? const CircularProgressIndicator()
//           : FlutterMap(
//         options: MapOptions(
//             center: myPosition,
//             // minZoom: 5, maxZoom: 40,
//             zoom: 18
//         ),
//         nonRotatedChildren: [
//           TileLayer(
//             urlTemplate:
//             'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
//             additionalOptions: const {
//               'accessToken': MAPBOX_ACCESS_TOKEN,
//               'id': 'mapbox/satellite-v9'
//             },
//           ),
//           MarkerLayer(
//             markers: [
//               Marker(
//                 point: myPosition!,
//                 builder: (context) {
//                   return Container(
//                     child: const Icon(
//                       Icons.circle,
//                       color: Colors.blueAccent,
//                       size: 20,
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//           PolylineLayer(
//             polylines: [
//               Polyline(
//                 points: points,
//                 color: Colors.blue,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class Shot {
  Shot({this.number, this.club, this.distance, this.color, this.lat, this.long, this.name});

  final number;
  final club;
  final distance;
  final color;
  final lat;
  final long;
  final name;
}

class ShotMarker extends Marker {
  ShotMarker({required this.shot})
      : super(
    // anchorPos: AnchorPos.align(AnchorAlign.top),
    height: MARKER_SIZE,
    width: MARKER_SIZE,
    point: LatLng(shot.lat, shot.long),
    builder: (BuildContext ctx) => Icon(
      Icons.circle,
      color: HexColor(shot.color),
      size: 15,
    ),
  );

  final Shot shot;
}

class ShotMarkerPopup extends StatelessWidget {
  const ShotMarkerPopup({Key? key,required this.shot}) : super(key: key);
  final Shot shot;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: HexColor('#${shot.color}'),
      child: Card(
        // shape: RoundedRectangleBorder(
        //   // borderRadius: BorderRadius.circular(15),
        // ),
        color: HexColor('#${shot.color}'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Image.network(shot.imagePath, width: 200),
            Text('Shot ${shot.number.toString()}',
              style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),
            Text('Player: ${shot.name}',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
            Text('Club: ${shot.club}',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
            Text('Distance: ${shot.distance}',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
          ],
        ),
      ),
    );
  }
}



class ExamplePopup extends StatefulWidget {
  final Marker marker;

  const ExamplePopup(this.marker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExamplePopupState();
}

class _ExamplePopupState extends State<ExamplePopup> {
  // final List<IconData> _icons = [
  //   Icons.star_border,
  //   Icons.star_half,
  //   Icons.star
  // ];
  // int _currentIcon = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        // onTap: () => setState(() {
        //   _currentIcon = (_currentIcon + 1) % _icons.length;
        // }),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 10),
            //   child: Icon(_icons[_currentIcon]),
            // ),
            _cardDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Shot ',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              'Position: ${widget.marker.point.latitude}, ${widget.marker.point.longitude}',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Marker size: ${widget.marker.width}, ${widget.marker.height}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}

class DataClass extends StatefulWidget {
  // final String title;
  final List<CardModel> datalist;
  const DataClass({Key? key, required this.datalist}) : super(key: key);


  @override
  State<DataClass> createState() => _DataClass();
}

class _DataClass extends State<DataClass> {
  List<DataRow> _rowList = [];
  List<DataColumn> _columnList = [
  ];
  // const DataClass({Key? key, required this.datalist}) : super(key: key);
  // final List<CardModel> datalist;


  // void _addColumn() {
  //
  //   for( DataRow r in _rowList)
  //     r.cells.add(ExerciseWidget(key: GlobalKey()));
  //
  //   _columnList.add(DataColumn(label: ExerciseName(key: GlobalKey())));
  //
  //   setState(() {
  //
  //   });
  // }
  // List<DataColumn> _createColumns() {
  //   return [
  //     DataColumn(label: Text('ID'), tooltip: 'Book identifier'),
  //     DataColumn(label: Text('Book')),
  //     DataColumn(label: Text('Author'))
  //   ];
  // }
  // debugPrint(widget.datalist);
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      // Using scrollView for scrolling and formating
        scrollDirection: Axis.vertical,
        // using FittedBox for fitting complte table in screen horizontally.
        child: FittedBox(
            child: DataTable(
              sortColumnIndex: 1,
              columnSpacing: 10,
              showCheckboxColumn: false,
              dataRowMinHeight: 40,
              // border: TableBorder.all(width: 1.0),
              // Data columns as required by APIs data.
              columns:
              // datalist.map((data) => DataColumn(label: Text(data.))).toList(),
              // data.map((e) => DataColumn(label: Text(e))).toList(),
              const [
                DataColumn(
                    label: Text(
                      "",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "1",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "2",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "3",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "4",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "5",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "6",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "7",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "8",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "9",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "IN",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "10",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "11",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "12",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "13",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "14",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "15",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "16",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "17",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "18",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
                DataColumn(
                    label: Text(
                      "OUT",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
              ],
              // Main logic and code for geting data and shoing it in table rows.
              rows: widget.datalist
                  .map(
                //maping each rows with datalist data
                      (data) => DataRow(cells: [
                    DataCell(
                      Text(data.empty,
                          style: const TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w500)),
                    ),
                    DataCell(Text(data.the1.toString(),
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w500))),
                    DataCell(
                      Text(data.the2.toString(),
                          style: const TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w500)),
                    ),
                        DataCell(
                          Text(data.the3.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the4.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the5.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the6.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the7.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the8.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the9.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.cardModelIn.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the10.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the11.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the12.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the13.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the14.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the15.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the16.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the17.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.the18.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(
                          Text(data.out.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)),
                        ),
                  ]))
                  .toList(), // converting at last into list.
            )));
  }
}






/// The home page of the application which hosts the datagrid.
class ScorecardTable extends StatefulWidget {
  /// Creates the home page.
  final id;
  ScorecardTable({Key? key, required this.id}) : super(key: key);



  @override
  _ScorecardTable createState() => _ScorecardTable();
}

class _ScorecardTable extends State<ScorecardTable> {
  // List<Employee> employees = <Employee>[];
  // List<CardModel> data;
  // late EmployeeDataSource employeeDataSource;
  late _JsonDataGridSource jsonDataGridSource;
  List<CardModel> card=[];
  var fields = [];
  // List<CardModel> tempdata=[];
  // @override
  // void initState() {
  //   super.initState();
  //   // data = widget.datalist;
  //   employeeDataSource = EmployeeDataSource(data: widget.datalist);
  // }
  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint(widget.id);
    final uri = Uri.http('www.golfoneclub.com', '/api/landing/card', {
      'playerProfileId': prefs.getInt('playerProfileId'),
      'card_id': widget.id
    } .map((key, value) => MapEntry(key, value.toString())));
    print(uri);
    http.Response response = await http.get(uri);
    debugPrint(response.body);
    print('Pepi');
    // List<CardModel> tempdata = cardModelFromJson(response.body);
    // jsonDataGridSource = _JsonDataGridSource(tempdata);
    // print(tempdata);
    // return tempdata;
    var list = json.decode(response.body).cast<Map<String, dynamic>>();
    card = await list.map<CardModel>((json) => CardModel.fromJson(json)).toList();
    print(list[0].keys);
    jsonDataGridSource = _JsonDataGridSource(card);
    fields = list[0].keys.toList();

    return card;
    // setState(() {
    //   jsonDataGridSource = tempdata;
    //   // loading = false;
    // });
  }

  // List<GridColumn> getColumns() {
  //   List<GridColumn> columns;
  //   columns = ([
  //     GridColumn(
  //       columnName: '',
  //       width: 100,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text(
  //           '',
  //           overflow: TextOverflow.clip,
  //           softWrap: true,
  //         ),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: 'the1',
  //       // width: 95,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text(
  //           '1',
  //           overflow: TextOverflow.clip,
  //           softWrap: true,
  //         ),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '2',
  //       // width: 95,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text(
  //           '2',
  //           overflow: TextOverflow.clip,
  //           softWrap: true,
  //         ),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '3',
  //       // width: 100,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text(
  //           '3',
  //           overflow: TextOverflow.clip,
  //           softWrap: true,
  //         ),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '4',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('4'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '5',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('5'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '6',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('6'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '7',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('7'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '8',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('8'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '9',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('9'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: 'in',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('IN'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '10',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('10'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '11',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('11'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '12',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('12'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '13',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('13'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '14',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('14'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '15',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('15'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '16',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('16'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '17',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('17'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: '18',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('18'),
  //       ),
  //     ),
  //     GridColumn(
  //       columnName: 'out',
  //       // width: 70,
  //       label: Container(
  //         padding: EdgeInsets.all(8),
  //         alignment: Alignment.center,
  //         color: HexColor("#009B77"),
  //         child: Text('OUT'),
  //       ),
  //     ),
  //   ]);
  //   return columns;
  // }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
         
    return FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                print(snapshot.hasData);
                print(fields);
                return snapshot.hasData
                    ? SfDataGrid(
                  // return SfDataGrid(
                    source: jsonDataGridSource,
                    columns: fields.map((e){
                      if (e == '') {
                        return GridColumn(
                          columnName: e.toString(),
                          width: 100,
                          label: Container(
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.center,
                            color: HexColor("#009B77"),
                            child: Text(
                              e.toString(),
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                          ),
                        );
                      } else {
                        return GridColumn(
                          columnName: e.toString(),
                          width: 50,
                          label: Container(
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.center,
                            color: HexColor("#009B77"),
                            child: Text(
                              e.toString(),
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                          ),
                        );
                      }

                    }).toList()
                    // getColumns()
                )
                    : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                  // child: Text('Pollon'),
                );
                // return SfDataGrid(
                //     source: jsonDataGridSource,
                //     columns: getColumns()
                // );
              });
  }

  // List<Employee> getEmployeeData() {
  //   return [
  //     Employee(10001, 'James', 'Project Lead', 20000),
  //     Employee(10002, 'Kathryn', 'Manager', 30000),
  //     Employee(10003, 'Lara', 'Developer', 15000),
  //     Employee(10004, 'Michael', 'Designer', 15000),
  //     Employee(10005, 'Martin', 'Developer', 15000),
  //     Employee(10006, 'Newberry', 'Developer', 15000),
  //     Employee(10007, 'Balnc', 'Developer', 15000),
  //     Employee(10008, 'Perry', 'Developer', 15000),
  //     Employee(10009, 'Gable', 'Developer', 15000),
  //     Employee(10010, 'Grimes', 'Developer', 15000)
  //   ];
  // }
}


class _JsonDataGridSource extends DataGridSource {
  _JsonDataGridSource(this.productlist) {
    buildDataGridRow();
  }

  late List<DataGridRow> dataGridRows = [];
  late List<CardModel> productlist = [];




  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          // Color getColor() {
          //   if (dataGridCell.columnName == '') {
          //     if (dataGridCell.value == 'Developer') {
          //       return Colors.tealAccent;
          //     } else if (dataGridCell.value == 'Manager') {
          //       return Colors.blue[200]!;
          //     }
          //   }
          //
          //   return Colors.transparent;
          // }

          Color getColor() {
            if (dataGridCell.columnName == '' || dataGridCell.columnName == 'IN' || dataGridCell.columnName == 'OUT'  ) {
              // if (dataGridCell.value == 'Developer') {
              //   return Colors.tealAccent;
              // } else if (dataGridCell.value == 'Manager') {
              //   return Colors.blue[200]!;
              // }
              return HexColor("#009B77");
            } else if (row.getCells()[0].value == 'Par') {
              return HexColor("#174038");
            } else if (row.getCells()[0].value == 'Net Score') {
               if (dataGridCell.value == null) {
                return Colors.transparent;
               } else if (dataGridCell.value < 0) {
                  return HexColor("#FCE300");
                } else if (dataGridCell.value == 1) {
                  return HexColor("#00b4d8");
                } else if (dataGridCell.value >= 2) {
                  return HexColor("#03045e");
                }
              return Colors.transparent;
            } else if (row.getCells()[0].value == 'GIR') {
              if (dataGridCell.value == null) {
                return Colors.transparent;
              } else if (dataGridCell.value >= 1) {
                return Colors.green;
              } else if (dataGridCell.value < 1) {
                return Colors.white;
              }
              return Colors.transparent;
            }

            return Colors.transparent;
          }

          TextStyle? getTextStyle() {
            // if (dataGridCell.columnName == 'designation') {
            //   if (dataGridCell.value == 'Developer') {
            //     return TextStyle(fontStyle: FontStyle.italic);
            //   } else if (dataGridCell.value == 'Manager') {
            //     return TextStyle(fontStyle: FontStyle.italic);
            //   }
            // }
            if (dataGridCell.columnName == '' || dataGridCell.columnName == 'IN' || dataGridCell.columnName == 'OUT' ) {
                    return TextStyle(color: Colors.white);
            }
            if (row.getCells()[0].value == 'GIR') {
              if (dataGridCell.value == 1) {
                 return TextStyle(color: Colors.green);
              }
              return TextStyle(color: Colors.white);
            } else if (row.getCells()[0].value == 'Penalties') {
                if (dataGridCell.value == 1 || dataGridCell.value == 2 ||
                    dataGridCell.value == 3 || dataGridCell.value == 4) {
                  return TextStyle(color: Colors.red);
                } else {
                  return TextStyle(color: Colors.white);
                }
              }
             else if (row.getCells()[0].value == 'Net Score') {
                   return TextStyle(color: Colors.white);
            }
             else if (row.getCells()[0].value == 'Score') {
               if (dataGridCell.value == null) {
                 return TextStyle(color: Colors.white);
               }
             }
             else if (row.getCells()[0].value == 'Fairway') {
               if (dataGridCell.value == null) {
                 return TextStyle(color: Colors.white);
               }
             }
               if (row.getCells()[0].value == 'Par') {
                 if (dataGridCell.value == null) {
                   return TextStyle(color: HexColor("#174038"));
                 }
               }

            else if (row.getCells()[0].value == 'Putts') {
              // if (dataGridCell.value == null) {
              //       return TextStyle(color: Colors.white);
              // }
              // else
              if (dataGridCell.value == null) {
                    return TextStyle(color: Colors.white);
              }
                else if (dataGridCell.value >= 3) {
                    return TextStyle(color: Colors.red);
              } else if (dataGridCell.value == 2) {
                    return TextStyle(color: Colors.green);
              } else if (dataGridCell.value < 2) {
                return TextStyle(color: HexColor("#FCE300"));
              }
            }
            return null;
          }

          return Container(
                  alignment: Alignment.center,
                  // color: HexColor("#009B77"),
                  color: getColor(),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    dataGridCell.value.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(),
                  ),
                );
            // Container(
            //   color: getColor(),
            //   alignment: (dataGridCell.columnName == 'id' ||
            //       dataGridCell.columnName == 'salary')
            //       ? Alignment.centerRight
            //       : Alignment.centerLeft,
            //   padding: EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Text(
            //     dataGridCell.value.toString(),
            //     overflow: TextOverflow.ellipsis,
            //     style: getTextStyle(),
            //   ));
        }).toList());
  }
    // return DataGridRowAdapter(cells: [
    //   Container(
    //     alignment: Alignment.center,
    //     color: HexColor("#009B77"),
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[0].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[1].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[2].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       // DateFormat('MM/dd/yyyy').format(row.getCells()[3].value).toString(),
    //       row.getCells()[3].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[4].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[5].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[6].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[7].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[8].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[9].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     color: HexColor("#009B77"),
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[10].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[11].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[12].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[13].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[14].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[15].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[16].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[17].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[18].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[19].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     color: HexColor("#009B77"),
    //     padding: EdgeInsets.all(8.0),
    //     child: Text(
    //       row.getCells()[20].value.toString(),
    //       overflow: TextOverflow.ellipsis,
    //     ),
    //   ),
    // ]);

  void buildDataGridRow() {
    dataGridRows = productlist.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: '', value: dataGridRow.empty),
        DataGridCell(
            columnName: '1', value: dataGridRow.the1),
        DataGridCell(
            columnName: '2', value: dataGridRow.the2),
        DataGridCell(
            columnName: '3', value: dataGridRow.the3),
        DataGridCell(columnName: '4', value: dataGridRow.the4),
        DataGridCell(columnName: '5', value: dataGridRow.the5),
        DataGridCell(columnName: '6', value: dataGridRow.the6),
        DataGridCell(columnName: '7', value: dataGridRow.the7),
        DataGridCell(columnName: '8', value: dataGridRow.the8),
        DataGridCell(columnName: '9', value: dataGridRow.the9),
        DataGridCell(columnName: 'IN', value: dataGridRow.cardModelIn),
        DataGridCell(columnName: '10', value: dataGridRow.the10),
        DataGridCell(columnName: '11', value: dataGridRow.the11),
        DataGridCell(columnName: '12', value: dataGridRow.the12),
        DataGridCell(columnName: '13', value: dataGridRow.the13),
        DataGridCell(columnName: '14', value: dataGridRow.the14),
        DataGridCell(columnName: '15', value: dataGridRow.the15),
        DataGridCell(columnName: '16', value: dataGridRow.the16),
        DataGridCell(columnName: '17', value: dataGridRow.the17),
        DataGridCell(columnName: '18', value: dataGridRow.the18),
        DataGridCell(columnName: 'OUT', value: dataGridRow.out),
      ]);
    }).toList(growable: false);
  }
}

// /// An object to set the employee collection data source to the datagrid. This
// /// is used to map the employee data to the datagrid widget.
// class EmployeeDataSource extends DataGridSource {
//   /// Creates the employee data source class with required details.
//   EmployeeDataSource({required List<CardModel> data}) {
//     _employeeData = data
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//       DataGridCell<String>(columnName: '', value: e.empty),
//       DataGridCell<int>(columnName: '1', value: e.the1),
//       DataGridCell<String>(
//           columnName: '2', value: e.the2),
//       DataGridCell<String>(columnName: '3', value: e.the3),
//     ]))
//         .toList();
//   }
//
//   List<DataGridRow> _employeeData = [];
//
//   @override
//   List<DataGridRow> get rows => _employeeData;
//
//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((e) {
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(8.0),
//             child: Text(e.value),
//           );
//         }).toList());
//   }
// }

// class _MyColor {
//   const _MyColor(this.color);
//
//   final HexColor color;
//   // final String name;
// }

extension HexColorCustom on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}


MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}