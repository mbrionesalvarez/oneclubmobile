import 'package:flutter/material.dart';
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
import 'package:oneclubmobile/views/scorecards.dart';
import 'package:oneclubmobile/views/search_friends.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: '');

  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      // appBar: AppBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   backgroundColor: HexColor("#174038"),
      //   automaticallyImplyLeading: false,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body:
      Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // UserInfo(name: name),

            UserMetrics(),
   Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child:
            FilledButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(title: 'Search Friends',)));
                },
                child: Container(
                  // height: 20,
                  // width: 20,
                  alignment: Alignment.center,
                  // decoration: BoxDecoration(color: Colors.blueAccent),
                  // decoration: BoxDecoration(
                  //   color: HexColor('#' + widget.color[key.key]),
                  //   border: Border.all(
                  //     color: HexColor('#' + widget.color[key.key]),
                  //   ),
                  //   // borderRadius: BorderRadius.all(Radius.circular(40)),
                  // ),
                  child: Text('+ Add friends',  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white
                  ),),
                ),),

    ),
            LatestActivitiesCards()

            // NavButtons(name: name,)

            // Text(
            //     '$name',
            // ),
            // BarChartAPI(),
            // SizedBox(
            //   width: size.height,
            //   height: size.height/2,
            //   child: StackedColumn100Chart(),
            // ),

            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //
      //   items: const [
      //     BottomNavigationBarItem(
      //         label: 'Home',
      //         icon: Icon(Icons.home)
      //
      //     ),
      //     BottomNavigationBarItem(
      //         label: 'Scorecards',
      //         icon: Icon(Icons.scoreboard)
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'More',
      //       icon: Icon(Icons.more_horiz, color: Colors.green,),
      //
      //
      //     ),
      //     // BottomNavigationBarItem(
      //     //     label: 'More',
      //     //     icon: Icon(Icons.more_horiz_sharp)
      //     // )
      //   ],
      // ),
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



class UserMetrics extends StatefulWidget {
  const UserMetrics({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<UserMetrics> createState() => _UserMetrics();
}

class _UserMetrics extends State<UserMetrics> {
  List<LastNScorecards> genders=[];
  bool loading = true;
  String name = '';
  String hcp = '';
  String rounds = '';
  String avg_score = '';
  String gir = '';
  String fw = '';
  String avg_putt = '';
  String approach = '';
  String putt = '';
  String short_game = '';
  String long_game = '';

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
      hcp = genders.single.hcp;
      rounds = genders.single.rounds;
      avg_score = genders.single.avgScore;
      gir = genders.single.gir;
      fw = genders.single.fairway;
      avg_putt = genders.single.avgPutt.toString();
      approach = genders.single.girTrend;
      putt = genders.single.puttTrend;
      short_game = genders.single.shortGameTrend;
      long_game = genders.single.longGameTrend;

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
        padding: const EdgeInsets.all(10),
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
                      hcp,
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
                    rounds,
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
      padding: const EdgeInsets.all(10),
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
          UserMetricsComponent(title: 'Strokes', value: avg_score),
          UserMetricsComponent(title: 'GIR', value: gir,),
          UserMetricsComponent(title: 'Fairway', value: fw,),
          UserMetricsComponent(title: 'Avg Putts', value: avg_putt,)
        ],
      ),
      SizedBox(height:50),
      Row(
        children: [
          UserMetricsComponent(title: 'Approach', value: approach,),
          UserMetricsComponent(title: 'Putt', value: putt,),
          UserMetricsComponent(title: 'Short Game', value: short_game,),
          UserMetricsComponent(title: 'Long Game', value: long_game,)
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Scorecards()));
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
// Color color = Theme.of(context).primaryColor;
//
// Widget buttonSection = Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     _buildButtonColumn(color, Icons.call, 'CALL'),
//     _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
//     _buildButtonColumn(color, Icons.share, 'SHARE'),
//   ],
// );
//
// class Info extends StatelessWidget {
//   const Info({super.key});
//
//   @override
//   Widget? build(BuildContext context) {
//     // ···
//   }
//
//   Column _buildButtonColumn(Color color, IconData icon, String label) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, color: color),
//         Container(
//           margin: const EdgeInsets.only(top: 8),
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: color,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


class LatestActivitiesCards extends StatefulWidget {
  /// Creates the home page.

  LatestActivitiesCards({Key? key}) : super(key: key);



  @override
  _LatestActivitiesCards createState() => _LatestActivitiesCards();
}

class _LatestActivitiesCards extends State<LatestActivitiesCards> {
  // List<Employee> employees = <Employee>[];
  // List<CardModel> data;
  // late EmployeeDataSource employeeDataSource;
  late _JsonDataGridSourceLatestActivitiesCards jsonDataGridSourceLatestActivitiesCards;
  List<LatestActivitiesModel> card = [];
  // List<TourLeaderboardModel> card2 = [];
  var fields = [];

  // List<CardModel> tempdata=[];
  // @override
  // void initState() {
  //   super.initState();
  //   // data = widget.datalist;
  //   employeeDataSource = EmployeeDataSource(data: widget.datalist);
  // }
  Future getDataTour() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // debugPrint(widget.id);
    final uri = Uri.http('www.golfoneclub.com', '/api/landing/friends_activities', {
      'playerProfileId': prefs.getInt('playerProfileId'),
    } .map((key, value) => MapEntry(key, value.toString())));
    print(uri);
    http.Response response = await http.get(uri);
    print(response.body);
    if (json.decode(response.body)['error'] == "No friends") {
      return 'No friends';
    }
    // // print('Pepi');
    // // List<CardModel> tempdata = cardModelFromJson(response.body);
    // // jsonDataGridSource = _JsonDataGridSource(tempdata);
    // // print(tempdata);
    // // return tempdata;
    var list = json.decode(response.body).cast<Map<String, dynamic>>();
    print(list);
    fields = ['Player', 'Date', 'Course', 'Score'];
    print('pescau');
    // List<TourPlayersCard> card = tourPlayersCardFromJson(response.body);

    card = list.map<LatestActivitiesModel>((json) => LatestActivitiesModel.fromJson(json)).toList();
    // print('catando');

    // print(fields);

    // print(card);
    // print(list[0].keys);

    jsonDataGridSourceLatestActivitiesCards = _JsonDataGridSourceLatestActivitiesCards(card);

    //
    print('pescau');
    return card;
    // setState(() {
    //   jsonDataGridSource = tempdata;
    //   // loading = false;
    // });
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDataTour(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.data);
          print(fields);
          if (snapshot.data == 'No friends') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black12,
                    size: 110,
                  ),
                  Text(
                    'Follow friends to see their scorecards',
                    style: TextStyle(
                      color: Colors.black12,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          } else {
            return snapshot.hasData
                ? SfDataGrid(
              // return SfDataGrid(
              // rowHeight: 80,
                source: jsonDataGridSourceLatestActivitiesCards,
                columns: fields.map((e) {
                  if (e == 'Course Name') {
                    return GridColumn(
                      columnName: e.toString(),
                      width: 200,
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
          }
        });
  }
}


class _JsonDataGridSourceLatestActivitiesCards extends DataGridSource {
  _JsonDataGridSourceLatestActivitiesCards(this.productlist) {
    buildDataGridRow();
  }

  late List<DataGridRow> dataGridRows = [];
  late List<LatestActivitiesModel> productlist = [];




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
            // if (dataGridCell.columnName == '' || dataGridCell.columnName == 'IN' || dataGridCell.columnName == 'OUT'  ) {
            //   // if (dataGridCell.value == 'Developer') {
            //   //   return Colors.tealAccent;
            //   // } else if (dataGridCell.value == 'Manager') {
            //   //   return Colors.blue[200]!;
            //   // }
            //   return HexColor("#009B77");
            // } else if (row.getCells()[0].value == 'Par') {
            //   return HexColor("#174038");
            // } else if (row.getCells()[0].value == 'Net Score') {
            //   if (dataGridCell.value == null) {
            //     return Colors.transparent;
            //   } else if (dataGridCell.value < 0) {
            //     return HexColor("#FCE300");
            //   } else if (dataGridCell.value == 1) {
            //     return HexColor("#00b4d8");
            //   } else if (dataGridCell.value >= 2) {
            //     return HexColor("#03045e");
            //   }
            //   return Colors.transparent;
            // } else if (row.getCells()[0].value == 'GIR') {
            //   if (dataGridCell.value == null) {
            //     return Colors.transparent;
            //   } else if (dataGridCell.value >= 1) {
            //     return Colors.green;
            //   } else if (dataGridCell.value < 1) {
            //     return Colors.white;
            //   }
            //   return Colors.transparent;
            // }

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
            // if (dataGridCell.columnName == '' || dataGridCell.columnName == 'IN' || dataGridCell.columnName == 'OUT' ) {
            //   return TextStyle(color: Colors.white);
            // }
            // if (row.getCells()[0].value == 'GIR') {
            //   if (dataGridCell.value == 1) {
            //     return TextStyle(color: Colors.green);
            //   }
            //   return TextStyle(color: Colors.white);
            // } else if (row.getCells()[0].value == 'Penalties') {
            //   if (dataGridCell.value == 1 || dataGridCell.value == 2 ||
            //       dataGridCell.value == 3 || dataGridCell.value == 4) {
            //     return TextStyle(color: Colors.red);
            //   } else {
            //     return TextStyle(color: Colors.white);
            //   }
            // }
            // else if (row.getCells()[0].value == 'Net Score') {
            //   return TextStyle(color: Colors.white);
            // }
            // else if (row.getCells()[0].value == 'Score') {
            //   if (dataGridCell.value == null) {
            //     return TextStyle(color: Colors.white);
            //   }
            // }
            // else if (row.getCells()[0].value == 'Fairway') {
            //   if (dataGridCell.value == null) {
            //     return TextStyle(color: Colors.white);
            //   }
            // }
            // if (row.getCells()[0].value == 'Par') {
            //   if (dataGridCell.value == null) {
            //     return TextStyle(color: HexColor("#174038"));
            //   }
            // }
            //
            // else if (row.getCells()[0].value == 'Putts') {
            //   // if (dataGridCell.value == null) {
            //   //       return TextStyle(color: Colors.white);
            //   // }
            //   // else
            //   if (dataGridCell.value == null) {
            //     return TextStyle(color: Colors.white);
            //   }
            //   else if (dataGridCell.value >= 3) {
            //     return TextStyle(color: Colors.red);
            //   } else if (dataGridCell.value == 2) {
            //     return TextStyle(color: Colors.green);
            //   } else if (dataGridCell.value < 2) {
            //     return TextStyle(color: HexColor("#FCE300"));
            //   }
            // }
            return TextStyle(fontSize: 12);
          }

          return Container(
            alignment: Alignment.center,
            // color: HexColor("#009B77"),

            color: getColor(),
            padding: EdgeInsets.all(8.0),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.visible,
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

  void buildDataGridRow() {
    dataGridRows = productlist.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(
            columnName: 'Player', value: dataGridRow.player.toString()),
        DataGridCell(columnName: 'Date', value:  '${dataGridRow.date.month}/${dataGridRow.date.day}/${dataGridRow.date.year}'),
        DataGridCell(
            columnName: 'Course', value: dataGridRow.course.toString()),
        DataGridCell(
            columnName: 'Score', value: dataGridRow.score.toString()),
      ]);
    }).toList(growable: false);
  }
}

