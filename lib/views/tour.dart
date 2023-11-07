import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';
import 'package:oneclubmobile/models/chart_models.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



// class Tour extends StatefulWidget {
//   Tour({Key? key,required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _Tour createState() => _Tour();
// }
//
// class _Tour extends State<Tour> {
//   String? query;
//   var playerProfileId;
//
//   // Future<List> searchFriends(String? query) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   final uri = Uri.http('www.golfoneclub.com', '/api/users/available', {
//   //     'playerProfileId': prefs.getInt('playerProfileId'),
//   //     'name': query,
//   //   } .map((key, value) => MapEntry(key, value.toString())));
//   //   print(uri);
//   //   final response = await http.get(uri);
//   //   print(json.decode(response.body));
//   //   List<AvailableFriends> tempdata = availableFriendsFromJson(response.body);
//   //   playerProfileId = prefs.getInt('playerProfileId');
//   //   return tempdata;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     // final api = Provider.of<ZomatoApi>(context);
//     // final state = Provider.of<AppState>(context);
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.title,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: HexColor('#174038'),
//         actions: [
//           InkWell(
//             onTap: () {
//               Navigator.pushNamed(context, 'filters');
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Icon(
//                 Icons.add,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             // SearchForm(
//             //   onSearch: (q) {
//             //     setState(() {
//             //       query = q;
//             //     });
//             //   },
//             // ),
//             // query == null
//             //     ? Expanded(
//             //   child: Column(
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     children: [
//             //       Icon(
//             //         Icons.search,
//             //         color: Colors.black12,
//             //         size: 110,
//             //       ),
//             //       Text(
//             //         'No results to display',
//             //         style: TextStyle(
//             //           color: Colors.black12,
//             //           fontSize: 20,
//             //           fontWeight: FontWeight.bold,
//             //         ),
//             //       )
//             //     ],
//             //   ),
//             // )
//             //     : FutureBuilder(
//             //   future: searchFriends(query),
//             //   builder: (context, snapshot) {
//             //     if (snapshot.connectionState == ConnectionState.waiting) {
//             //       return Expanded(
//             //           child: Center(
//             //
//             //             child: CircularProgressIndicator(),
//             //           ));
//             //     }
//             //
//             //     if (snapshot.hasData) {
//             //       return Expanded(
//             //         child: ListView(
//             //           children: snapshot.data?.map<Widget>(
//             //                   (json) => RestaurantItem(restaurant: json, playerId: playerProfileId))
//             //               .toList() ?? [],
//             //         ),
//             //       );
//             //     }
//             //
//             //     return Text(
//             //         'Error retrieving results: ${snapshot.error}');
//             //   },
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }


Future<void> navigate(BuildContext context, String route,
    {bool isDialog = false,
      bool isRootNavigator = true,
      Map<String, dynamic>? arguments}) =>
    Navigator.of(context, rootNavigator: isRootNavigator)
        .pushNamed(route, arguments: arguments);
final productsKey = GlobalKey<NavigatorState>();
final NavbarNotifier _navbarNotifier = NavbarNotifier();
final homeKey = GlobalKey<NavigatorState>();
final profileKey = GlobalKey<NavigatorState>();

class Tour extends StatefulWidget {
  const Tour({Key? key}) : super(key: key);
  static const String route = '/tour';
  @override
  State<Tour> createState() => _Tour();
}
class _Tour extends State<Tour> {

  List<TourModel> tours=[];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.http('www.golfoneclub.com', '/api/tour', {
      'playerProfileId': prefs.getInt('playerProfileId'),
    } .map((key, value) => MapEntry(key, value.toString())));
    http.Response response = await http.get(uri);
    debugPrint(response.body);
    List<TourModel> tempdata = tourModelFromJson(response.body);
    setState(() {
      tours = tempdata;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Tour',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: HexColor('#174038'),
          actions: [
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, 'filters');
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTour(title: 'New Tour', id: Null,)));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          ],
        ),
    body: ProductList(data: tours,)
    // Navigator(
    //       key: productsKey,
    //       initialRoute: '/tour',
    //       onGenerateRoute: (RouteSettings settings) {
    //         WidgetBuilder builder;
    //         switch (settings.name) {
    //           case '/tour':
    //             builder = (BuildContext _) => ProductList(data: tours,);
    //             break;
    //           case ProductDetail.route:
    //             final id = (settings.arguments as Map)['id'];
    //             builder = (BuildContext _) {
    //               return ProductDetail(
    //                 id: id,
    //               );
    //             };
    //             break;
    //           default:
    //             builder = (BuildContext _) => ProductList(data: tours,);
    //         }
    //         return MaterialPageRoute(builder: builder, settings: settings);
    //       })
    );
    // return Theme(
    //   data: ThemeData(
    //       colorScheme:
    //       Theme.of(context).colorScheme.copyWith(primary: HexColor("#174038"))),
    //   child: Navigator(
    //       key: productsKey,
    //       initialRoute: '/',
    //       onGenerateRoute: (RouteSettings settings) {
    //         WidgetBuilder builder;
    //         switch (settings.name) {
    //           case '/':
    //             builder = (BuildContext _) => ProductList(data: scorecards,);
    //             break;
    //           case ProductDetail.route:
    //             final id = (settings.arguments as Map)['id'];
    //             builder = (BuildContext _) {
    //               return ProductDetail(
    //                 id: id,
    //               );
    //             };
    //             break;
    //           default:
    //             builder = (BuildContext _) => ProductList(data: scorecards,);
    //         }
    //         return MaterialPageRoute(builder: builder, settings: settings);
    //       }),
    // );
  }
}


class ProductList extends StatefulWidget {
  final List<TourModel> data;
  const ProductList({Key? key, required this.data}) : super(key: key);
  static const String route = '/tour';



  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _scrollController = ScrollController();
  // List<ScorecardsModel> scorecards=[];
  bool loading = true;


  @override
  void initState() {
    super.initState();
    _addScrollListener();
    // getData();
  }

  // void getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final uri = Uri.http('www.golfoneclub.com', '/api/landing/scorecards', {
  //     'playerProfileId': prefs.getInt('playerProfileId'),
  //   } .map((key, value) => MapEntry(key, value.toString())));
  //   http.Response response = await http.get(uri);
  //   debugPrint(response.body);
  //   List<ScorecardsModel> tempdata = scorecardsModelFromJson(response.body);
  //   setState(() {
  //     scorecards = tempdata;
  //     loading = false;
  //   });
  // }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = false;
        }
      } else {
        if (!_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    //   Scaffold(
    //     appBar: AppBar(
    //     title: Text(
    //     'Tour',
    //     style: TextStyle(fontWeight: FontWeight.bold),
    // ),
    // centerTitle: true,
    // backgroundColor: HexColor('#174038'),
    // actions: [
    // InkWell(
    // onTap: () {
    // Navigator.pushNamed(context, 'filters');
    // },
    // child: Padding(
    // padding: const EdgeInsets.symmetric(horizontal: 15),
    // child: Icon(
    // Icons.add,
    // ),
    // ),
    // ),
    // ],
    // ),
    // body:
    ListView.builder(
          controller: _scrollController,
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            final card = widget.data[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    _navbarNotifier.hideBottomNavBar = false;
                    // navigate(context, ProductDetail.route,
                    //     isRootNavigator: false,
                    //     arguments: {'id': card.id
                    //       // , 'card_id': widget.data.single.cardId, 'name': 'pe'
                    //     });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(id: card.id, name: card.name,)));
                  },
                  child: ProductTile(index: index, data: card)),
            );
          })
      ;
  }
}

class ProductTile extends StatelessWidget {
  final int index;
  final TourModel data;
  // ProductTile({this.data});
  const ProductTile({Key? key, required this.index, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey.withOpacity(0.5),
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              height: 75,
              width: 75,
              color: HexColor('#009B77'),
              alignment: Alignment.center,
              child: Column(children:
                  [Text('Members', style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                Container(
                    margin: const EdgeInsets.all(8),
                    height: 30,
                    width: 30,
                    color: HexColor('#009B77'),
                    alignment: Alignment.center,
                    child: Text('${data.members}', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),)),])
            ),
            Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: TextDirection.ltr,
                        children: [
                          Text('${data.name}',
                            // overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: HexColor('#009B77'),
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          Text('Start: ${data.start.month}/${data.start.day}/${data.start.year}', style: TextStyle(
                              color: HexColor('#009B77'),
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),),
                          Text('End: ${data.end.month}/${data.end.day}/${data.end.year}', style: TextStyle(
                              color: HexColor('#009B77'),
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),),
                        ]
                    ))
            )
          ],
        ));
  }
}


class ProductDetail extends StatefulWidget {
  // final List<ScorecardsModel> data;
  final id;
  final name;

  // const ProductDetail({Key? key, this.id = '1'}) : super(key: key);
  // final String card_id;
  // final String name;

  static const String route = '/tour/detail';
  const ProductDetail({Key? key, required this.id, required this.name}) : super(key: key);
  // static const String route = '/';



  @override
  State<ProductDetail> createState() => _ProductDetail();
}

class _ProductDetail extends State<ProductDetail> {

  List<CardModel> card=[];
  bool loading = true;


  @override
  void initState() {
    super.initState();
    // _addScrollListener();
    // getData();
  }

  // void getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   debugPrint(widget.id);
  //   final uri = Uri.http('www.golfoneclub.com', '/api/landing/card', {
  //     'playerProfileId': prefs.getInt('playerProfileId'),
  //     'card_id': widget.id
  //   } .map((key, value) => MapEntry(key, value.toString())));
  //   print(uri);
  //   http.Response response = await http.get(uri);
  //   debugPrint(response.body);
  //   List<CardModel> tempdata = cardModelFromJson(response.body);
  //   setState(() {
  //     card = tempdata;
  //     loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTour(title: 'Edit Tour', id: widget.id,)));
            },
          )
        ],
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Text('${widget.id}'),
          Container(
            // padding: const EdgeInsets.all(5),
            // Data Table logic and code is in DataClass
              height: 350,
              child:
              // DataClass(datalist: card)
              TourLeaderboard(id: widget.id)),
          // SizedBox(height:10),
          InkWell(
            onTap: () {
              _navbarNotifier.hideBottomNavBar = false;
              // navigate(context, ProductRoundStats.route,
              //     isRootNavigator: false, arguments: {'id': widget.id.toString()});
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TourRoundStats(id: widget.id.toString(),)));
              // navigate(context, ProductDetail.route,
              //     isRootNavigator: false,
              //     arguments: {'id': card.cardId
              //       // , 'card_id': widget.data.single.cardId, 'name': 'pe'
              //     });
            },

            child: Container(
              height: 50,
              // padding: const EdgeInsets.all(8),
              color: HexColor("#009B77"),
              child:  Center(child: Text('Tour Stats', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: HexColor('#FCE300')
              ),)),
            ),),
          SizedBox(height:10),
          InkWell(
            onTap: () {
              _navbarNotifier.hideBottomNavBar = false;
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Players(id: widget.id,)));
              // navigate(context, ProductDetail.route,
              //     isRootNavigator: false,
              //     arguments: {'id': card.cardId
              //       // , 'card_id': widget.data.single.cardId, 'name': 'pe'
              //     });
            },

            child: Container(
              height: 50,
              // padding: const EdgeInsets.all(8),
              color: HexColor("#009B77"),
              child:  Center(child: Text('Players', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: HexColor('#FCE300')
              ),)),
            ),),
          // SizedBox(height:10),
          // InkWell(
          //   onTap: () {
          //     _navbarNotifier.hideBottomNavBar = false;
          //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Tour()));
          //     // navigate(context, ProductDetail.route,
          //     //     isRootNavigator: false,
          //     //     arguments: {'id': card.cardId
          //     //       // , 'card_id': widget.data.single.cardId, 'name': 'pe'
          //     //     });
          //   },
          //   child: Container(
          //     height: 50,
          //     color: HexColor("#009B77"),
          //     child:  Center(child: Text('Events', style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 20,
          //         color: HexColor('#FCE300')
          //     ),)),
          //   ),),
          // SizedBox(height:10),
          // InkWell(
          //   onTap: () {
          //     _navbarNotifier.hideBottomNavBar = false;
          //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Tour()));
          //     // navigate(context, ProductDetail.route,
          //     //     isRootNavigator: false,
          //     //     arguments: {'id': card.cardId
          //     //       // , 'card_id': widget.data.single.cardId, 'name': 'pe'
          //     //     });
          //   },
          //   child: Container(
          //     height: 50,
          //     color: HexColor("#009B77"),
          //     child:  Center(child: Text('Courses', style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 20,
          //         color: HexColor('#FCE300')
          //     ),)),
          //   ),),
          //
          //
          // // const Center(
          // //   child: Placeholder(
          // //     fallbackHeight: 200,
          // //     fallbackWidth: 300,
          // //   ),
          // // ),
          //
          // FilledButton(
          //     onPressed: () {
          //       _navbarNotifier.hideBottomNavBar = false;
          //       navigate(context, ProductComments.route,
          //           isRootNavigator: false, arguments: {'id': widget.id.toString()});
          //     },
          //     child: const Text('Holes')),
          // FilledButton(
          //     onPressed: () {
          //       _navbarNotifier.hideBottomNavBar = false;
          //       navigate(context, ProductRoundStats.route,
          //           isRootNavigator: false, arguments: {'id': widget.id.toString()});
          //     },
          //     child: const Text('Round Stats'))
        ],
      ),
    );
  }
}


class TourLeaderboard extends StatefulWidget {
  /// Creates the home page.
  final id;
  TourLeaderboard({Key? key, required this.id}) : super(key: key);



  @override
  _TourLeaderboard createState() => _TourLeaderboard();
}

class _TourLeaderboard extends State<TourLeaderboard> {
  // List<Employee> employees = <Employee>[];
  // List<CardModel> data;
  // late EmployeeDataSource employeeDataSource;
  late _JsonDataGridSourceTourLeaderbard jsonDataGridSourceTourLeaderbard;
  List<TourLeaderboardModel> card = [];
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // debugPrint(widget.id);
    final uri = Uri.http('www.golfoneclub.com', '/api/tour/leaderboard', {
      // 'playerProfileId': prefs.getInt('playerProfileId'),
      'tour_id': widget.id
    } .map((key, value) => MapEntry(key, value.toString())));
    print(uri);
    http.Response response = await http.get(uri);
    // debugPrint(response.body);
    // // print('Pepi');
    // // List<CardModel> tempdata = cardModelFromJson(response.body);
    // // jsonDataGridSource = _JsonDataGridSource(tempdata);
    // // print(tempdata);
    // // return tempdata;
    var list = json.decode(response.body).cast<Map<String, dynamic>>();
    card = await list.map<TourLeaderboardModel>((json) => TourLeaderboardModel.fromJson(json)).toList();
    // print('catando');
    // print(list[0].keys);
    jsonDataGridSourceTourLeaderbard = _JsonDataGridSourceTourLeaderbard(card);
    fields = ['Player',  'Events', 'Points/Hole','Points'];
    //
    return card;
    // setState(() {
    //   jsonDataGridSource = tempdata;
    //   // loading = false;
    // });
  }

  // void getData() async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   print(widget.id);
  //   final uri = Uri.http('www.golfoneclub.com', '/api/tour/leaderboard', {
  //     // 'playerProfileId': prefs.getInt('playerProfileId'),
  //     'tour_id': widget.id
  //   } .map((key, value) => MapEntry(key, value.toString())));
  //   print(uri);
  //   http.Response response = await http.get(uri);
  //   debugPrint(response.body);
  //   var list = json.decode(response.body).cast<Map<String, dynamic>>();
  //   List<TourLeaderboardModel> card = tourLeaderboardModelFromJson(response.body);
  //   // print('catando');
  //   print(card);
  //   // jsonDataGridSourceTourLeaderbard = _JsonDataGridSourceTourLeaderbard(card);
  //   fields = list[0].keys.toList();
  //   print(fields);
  //   //
  //   // return card;
  //   setState(() {
  //     jsonDataGridSourceTourLeaderbard = _JsonDataGridSourceTourLeaderbard(card);
  //     // loading = false;
  //   });
  // }

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
          print(snapshot.hasData);
          print(fields);
          if (snapshot.hasData) {
          if (fields.length == 0) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black12,
                    size: 110,
                  ),
                  Text(
                    'Head to the course',
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
            return SfDataGrid(
              // return SfDataGrid(
                source: jsonDataGridSourceTourLeaderbard,
                columns: fields.map((e) {
                  if (e == 'Player') {
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
            );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
              // child: Text('Pollon'),
            );
          }
          // return SfDataGrid(
          //     source: jsonDataGridSource,
          //     columns: getColumns()
          // );

        });

  }
}


class _JsonDataGridSourceTourLeaderbard extends DataGridSource {
  _JsonDataGridSourceTourLeaderbard(this.productlist) {
    buildDataGridRow();
  }

  late List<DataGridRow> dataGridRows = [];
  late List<TourLeaderboardModel> productlist = [];




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
            return null;
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
        DataGridCell<String>(columnName: 'Player', value: dataGridRow.player),
        DataGridCell(
            columnName: 'Events', value: dataGridRow.eventsPlayed),
        DataGridCell(
            columnName: 'Points Per Hole', value: dataGridRow.pointsPerHole),
        DataGridCell(
            columnName: 'Points', value: dataGridRow.points),
        // DataGridCell(columnName: '4', value: dataGridRow.the4),
        // DataGridCell(columnName: '5', value: dataGridRow.the5),
        // DataGridCell(columnName: '6', value: dataGridRow.the6),
        // DataGridCell(columnName: '7', value: dataGridRow.the7),
        // DataGridCell(columnName: '8', value: dataGridRow.the8),
        // DataGridCell(columnName: '9', value: dataGridRow.the9),
        // DataGridCell(columnName: 'IN', value: dataGridRow.cardModelIn),
        // DataGridCell(columnName: '10', value: dataGridRow.the10),
        // DataGridCell(columnName: '11', value: dataGridRow.the11),
        // DataGridCell(columnName: '12', value: dataGridRow.the12),
        // DataGridCell(columnName: '13', value: dataGridRow.the13),
        // DataGridCell(columnName: '14', value: dataGridRow.the14),
        // DataGridCell(columnName: '15', value: dataGridRow.the15),
        // DataGridCell(columnName: '16', value: dataGridRow.the16),
        // DataGridCell(columnName: '17', value: dataGridRow.the17),
        // DataGridCell(columnName: '18', value: dataGridRow.the18),
        // DataGridCell(columnName: 'OUT', value: dataGridRow.out),
      ]);
    }).toList(growable: false);
  }
}

class TourRoundStats extends StatefulWidget {
  // const MapScreen({super.key});
  final id;
  // final hole;
  static const String route = '/tour/detail/roundstats';
  TourRoundStats({Key? key, required this.id}) : super(key: key);

  @override
  State<TourRoundStats> createState() => _TourRoundStats();
}

class _TourRoundStats extends State<TourRoundStats> {
  // final String id;
  // const ProductComments({Key? key, this.id = '1'}) : super(key: key);
  var fields = [];
  var list;
  var colors;
  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // debugPrint(widget.id);
    final uri = Uri.http('www.golfoneclub.com', '/api/tour/stats', {
      'playerProfileId': prefs.getInt('playerProfileId'),
      'tour_id': widget.id,
      'unit': prefs.getString('unit')
    } .map((key, value) => MapEntry(key, value.toString())));
    print(uri);
    http.Response response = await http.get(uri);
    print(response.body);
    // List<CardModel> tempdata = cardModelFromJson(response.body);
    // jsonDataGridSource = _JsonDataGridSource(tempdata);
    // print(tempdata);
    // return tempdata;
    // var list = json.decode(response.body).cast<Map<String, dynamic>>();
    var data = json.decode(response.body);
    list = data['data'];
    colors = data['users'];
    // card = await list.map<CardModel>((json) => CardModel.fromJson(json)).toList();
    print(list['Score']);
    // jsonDataGridSource = _JsonDataGridSource(card);
    fields = list.keys.toList();
    return fields;
    // return card;
    // setState(() {
    //   jsonDataGridSource = tempdata;
    //   // loading = false;
    // });
  }



  @override
  void initState() {
    // getCurrentLocation();
    super.initState();
    // getData();
    // map = MapScreen(id: widget.id, hole: _hole,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text('${widget.id}'),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              print(snapshot.hasData);
              // print(center);
              // print(fields);
              return snapshot.hasData
                  ? Center(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      // [RoundStatsGauge(title: 'Approach', value: 18,),
                      //   // RoundStatsGauge(title: 'Approach', value: 18,),
                      //   // RoundStatsGauge(title: 'Approach', value: 18,)
                      // ]
                      fields.map((e){
                        if (e == 'Rank') {
                          return RoundStatsGauge(title: e.toString(), value: list[e.toString()], color: colors,);
                        } else {
                          return RoundStatsGauge(title: e.toString(), value: list[e.toString()], color: colors);
                        }

                      }).toList()
                  )
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
            })


      // MapScreen(id: widget.id, hole: _hole,),
      // FutureBuilder(
      //     future: _incrementCounter(),
      //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //
      //       // print(fields);
      //       return MapScreen(id: widget.id, hole: _hole,);}),
      // Column(
      //     children: [
      //     DropdownMenuExample(),
      //   MapScreen()]),
      // floatingActionButton: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       FloatingActionButton(
      //         child: Icon(
      //             Icons.arrow_left
      //         ),
      //         onPressed: () {
      //           _decrementCounter();
      //         },
      //         heroTag: null,
      //         backgroundColor: HexColor('#009B77'),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       FloatingActionButton(
      //         child: Icon(
      //           Icons.arrow_right,
      //
      //         ),
      //         onPressed: () => _incrementCounter(),
      //         heroTag: null,
      //         backgroundColor: HexColor('#009B77'),
      //       )
      //     ]
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      //   FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}


class RoundStatsGauge extends StatefulWidget {
  const RoundStatsGauge({super.key, required this.title, required this.value, required this.color});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final title;
  final value;
  final color;

  @override
  State<RoundStatsGauge> createState() => _RoundStatsGauge();
}

class _RoundStatsGauge extends State<RoundStatsGauge> {

  List<LinearMarkerPointer> marks = [];
  List<LinearBarPointer> gradient = [];
  List range = [];
  double max=100;
  double min=0;
  @override
  void initState() {
    getData();
    super.initState();


  }

  void getData() async {
    for(var key in widget.value.entries) {
      print(key.key);
      print(widget.color);
      var value;
      if (key.value == "N/A") {
        break;
      }
      // else if (key.value is int) {
      //   value = key.value;
      // }
      else {
        value = key.value.toDouble();
    }
      marks.add(LinearWidgetPointer(
        value: value,
        position: LinearElementPosition.outside,
        child: Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          // decoration: BoxDecoration(color: Colors.blueAccent),
          decoration: BoxDecoration(
            color: HexColor('#' + widget.color[key.key]),
            border: Border.all(
              color: HexColor('#' + widget.color[key.key]),
            ),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: Text(key.key,  style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Colors.white
          ),),
        ),
      ));
      marks.add(LinearWidgetPointer(
        value: key.value.toDouble(),
        child: Container(
          height: 20,
          width: 2,
          decoration: BoxDecoration(color: HexColor('#' + widget.color[key.key])),
          // child: Text('BW'),
        ),
      ),);
      range.add(key.value.toDouble());
      print(range.reduce((curr, next) => curr > next? curr: next));
    }
    min = range.reduce((curr, next) => curr < next? curr: next);
    max = range.reduce((curr, next) => curr > next? curr: next);
    if (min == max) {
      min = min - 2;
      max = max + 2;
    }
    if (['GIR (%)', 'Fairway (%)', 'Driver Avg', 'Driver Max', 'Up & Down (%)'].contains(widget.title)) {
      gradient.add(LinearBarPointer(
          value: max,
          thickness: 30,
          //Apply linear gradient
          shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.redAccent, Colors.greenAccent])
              .createShader(bounds)
      ));
    } else {
      gradient.add(LinearBarPointer(
          value: max,
          thickness: 30,
          //Apply linear gradient
          shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.greenAccent, Colors.redAccent])
              .createShader(bounds)
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    print(widget.value);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
        SizedBox(height:10),
        SfLinearGauge(
            showTicks: false,
            minimum: min,
            maximum: max,
            minorTicksPerInterval: 1,
            labelOffset: 10,
            barPointers: gradient,
            // [
            //   LinearBarPointer(
            //       value: max,
            //       thickness: 30,
            //       //Apply linear gradient
            //       shaderCallback: (bounds) => LinearGradient(
            //           begin: Alignment.centerLeft,
            //           end: Alignment.centerRight,
            //           colors: [Colors.redAccent, Colors.greenAccent])
            //           .createShader(bounds)
            //   ),
            // ],
            markerPointers: marks
          // List<LinearMarkerPointer>.from(widget.value.entries
          //     .map(
          //       (entry) {
          //         return LinearWidgetPointer(
          //           value: entry.value.toDouble(),
          //           child: Container(
          //             height: 60,
          //             width: 10,
          //             alignment: Alignment.topCenter,
          //             // decoration: BoxDecoration(color: Colors.blueAccent),
          //             child: Text(entry.key),
          //           ),
          //         );
          //
          //
          //       }
          // ))

          // [
          // LinearWidgetPointer(
          //   value: entry.value,
          //   child: Container(
          //     height: 20,
          //     width: 2,
          //     decoration: BoxDecoration(color: Colors.blueAccent),
          //     // child: Text('BW'),
          //   ),
          // ),
          // LinearWidgetPointer(
          //   value: entry.value,
          //   child: Container(
          //     height: 60,
          //     width: 10,
          //     alignment: Alignment.topCenter,
          //     // decoration: BoxDecoration(color: Colors.blueAccent),
          //     child: Text(entry.key),
          //   ),
          // ),
          // ],
        ),
        SizedBox(height:10),
      ],

    );
  }
}



class NavbarNotifier extends ChangeNotifier {
  int _index = 0;
  int get index => _index;
  bool _hideBottomNavBar = false;

  set index(int x) {
    _index = x;
    notifyListeners();
  }

  bool get hideBottomNavBar => _hideBottomNavBar;
  set hideBottomNavBar(bool x) {
    _hideBottomNavBar = x;
    notifyListeners();
  }

  // pop routes from the nested navigator stack and not the main stack
  // this is done based on the currentIndex of the bottom navbar
  // if the backButton is pressed on the initial route the app will be terminated
  FutureOr<bool> onBackButtonPressed() async {
    bool exitingApp = true;
    switch (_navbarNotifier.index) {
      case 0:
        if (homeKey.currentState != null && homeKey.currentState!.canPop()) {
          homeKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      case 1:
        if (productsKey.currentState != null &&
            productsKey.currentState!.canPop()) {
          productsKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      case 2:
        if (profileKey.currentState != null &&
            profileKey.currentState!.canPop()) {
          profileKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      default:
        return false;
    }
    if (exitingApp) {
      return true;
    } else {
      return false;
    }
  }

  // pops all routes except first, if there are more than 1 route in each navigator stack
  void popAllRoutes(int index) {
    switch (index) {
      case 0:
        if (homeKey.currentState!.canPop()) {
          homeKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 1:
        if (productsKey.currentState!.canPop()) {
          productsKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 2:
        if (profileKey.currentState!.canPop()) {
          profileKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      default:
        break;
    }
  }
}


class Players extends StatefulWidget {
  final id;
  const Players({Key? key, required this.id}) : super(key: key);
  static const String route = '/tour/player';
  @override
  State<Players> createState() => _Players();
}
class _Players extends State<Players> {

  List<TourPlayers> players=[];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.http('www.golfoneclub.com', '/api/tour/players', {
      'tour_id': widget.id,
    } .map((key, value) => MapEntry(key, value.toString())));
    http.Response response = await http.get(uri);
    debugPrint(response.body);
    List<TourPlayers> tempdata = tourPlayersFromJson(response.body);
    setState(() {
      players = tempdata;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Players',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: HexColor('#174038'),
          // actions: [
          //   InkWell(
          //     onTap: () {
          //       Navigator.pushNamed(context, 'filters');
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 15),
          //       child: Icon(
          //         Icons.add,
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: PlayersList(id: widget.id ,data: players,)
      // Navigator(
      //       key: productsKey,
      //       initialRoute: '/tour',
      //       onGenerateRoute: (RouteSettings settings) {
      //         WidgetBuilder builder;
      //         switch (settings.name) {
      //           case '/tour':
      //             builder = (BuildContext _) => ProductList(data: tours,);
      //             break;
      //           case ProductDetail.route:
      //             final id = (settings.arguments as Map)['id'];
      //             builder = (BuildContext _) {
      //               return ProductDetail(
      //                 id: id,
      //               );
      //             };
      //             break;
      //           default:
      //             builder = (BuildContext _) => ProductList(data: tours,);
      //         }
      //         return MaterialPageRoute(builder: builder, settings: settings);
      //       })
    );
    // return Theme(
    //   data: ThemeData(
    //       colorScheme:
    //       Theme.of(context).colorScheme.copyWith(primary: HexColor("#174038"))),
    //   child: Navigator(
    //       key: productsKey,
    //       initialRoute: '/',
    //       onGenerateRoute: (RouteSettings settings) {
    //         WidgetBuilder builder;
    //         switch (settings.name) {
    //           case '/':
    //             builder = (BuildContext _) => ProductList(data: scorecards,);
    //             break;
    //           case ProductDetail.route:
    //             final id = (settings.arguments as Map)['id'];
    //             builder = (BuildContext _) {
    //               return ProductDetail(
    //                 id: id,
    //               );
    //             };
    //             break;
    //           default:
    //             builder = (BuildContext _) => ProductList(data: scorecards,);
    //         }
    //         return MaterialPageRoute(builder: builder, settings: settings);
    //       }),
    // );
  }
}


class PlayersList extends StatefulWidget {
  final List<TourPlayers> data;
  final id;
  const PlayersList({Key? key, required this.data, required this.id}) : super(key: key);
  static const String route = '/tour';



  @override
  State<PlayersList> createState() => _PlayersList();
}

class _PlayersList extends State<PlayersList> {
  final _scrollController = ScrollController();
  // List<ScorecardsModel> scorecards=[];
  bool loading = true;


  @override
  void initState() {
    super.initState();
    _addScrollListener();
    // getData();
  }

  // void getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final uri = Uri.http('www.golfoneclub.com', '/api/landing/scorecards', {
  //     'playerProfileId': prefs.getInt('playerProfileId'),
  //   } .map((key, value) => MapEntry(key, value.toString())));
  //   http.Response response = await http.get(uri);
  //   debugPrint(response.body);
  //   List<ScorecardsModel> tempdata = scorecardsModelFromJson(response.body);
  //   setState(() {
  //     scorecards = tempdata;
  //     loading = false;
  //   });
  // }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = false;
        }
      } else {
        if (!_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      //   Scaffold(
      //     appBar: AppBar(
      //     title: Text(
      //     'Tour',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      // ),
      // centerTitle: true,
      // backgroundColor: HexColor('#174038'),
      // actions: [
      // InkWell(
      // onTap: () {
      // Navigator.pushNamed(context, 'filters');
      // },
      // child: Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 15),
      // child: Icon(
      // Icons.add,
      // ),
      // ),
      // ),
      // ],
      // ),
      // body:
      ListView.builder(
          controller: _scrollController,
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            final card = widget.data[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    _navbarNotifier.hideBottomNavBar = false;
                    // navigate(context, ProductDetail.route,
                    //     isRootNavigator: false,
                    //     arguments: {'id': card.id
                    //       // , 'card_id': widget.data.single.cardId, 'name': 'pe'
                    //     });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerDetail(id: card.playerProfileId, name: card.name,tour_id: widget.id, )));
                  },
                  child: PlayerTile(index: index, data: card)),
            );
          })
    ;
  }
}

class PlayerTile extends StatelessWidget {
  final int index;
  final TourPlayers data;
  // ProductTile({this.data});
  const PlayerTile({Key? key, required this.index, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: HexColor("#009B77"),
        height: 50,
        child: Center(child: Text('${data.name}', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: HexColor('#FCE300')
          ),)),

            // Flexible(
            //     child: Padding(
            //         padding: const EdgeInsets.only(left: 16.0),
            //         child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             textDirection: TextDirection.ltr,
            //             children: [
            //               Text('${data.name}',
            //                 // overflow: TextOverflow.ellipsis,
            //                 softWrap: true,
            //                 overflow: TextOverflow.ellipsis,
            //                 style: TextStyle(
            //                     color: HexColor('#009B77'),
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.bold
            //                 ),),
            //               Text('Start: ${data.start.month}/${data.start.day}/${data.start.year}', style: TextStyle(
            //                   color: HexColor('#009B77'),
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.bold
            //               ),),
            //               Text('End: ${data.end.month}/${data.end.day}/${data.end.year}', style: TextStyle(
            //                   color: HexColor('#009B77'),
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.bold
            //               ),),
            //             ]
            //         ))
            // )
         );
  }
}


class PlayerDetail extends StatefulWidget {
  // final List<ScorecardsModel> data;
  final id;
  final name;
  final tour_id;

  // const ProductDetail({Key? key, this.id = '1'}) : super(key: key);
  // final String card_id;
  // final String name;

  static const String route = '/tour/detail';
  const PlayerDetail({Key? key, required this.id, required this.name, required this.tour_id}) : super(key: key);
  // static const String route = '/';



  @override
  State<PlayerDetail> createState() => _PlayerDetail();
}

class _PlayerDetail extends State<PlayerDetail> {

  List<CardModel> card=[];
  bool loading = true;


  @override
  void initState() {
    super.initState();
    // _addScrollListener();
    // getData();
  }

  // void getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   debugPrint(widget.id);
  //   final uri = Uri.http('www.golfoneclub.com', '/api/landing/card', {
  //     'playerProfileId': prefs.getInt('playerProfileId'),
  //     'card_id': widget.id
  //   } .map((key, value) => MapEntry(key, value.toString())));
  //   print(uri);
  //   http.Response response = await http.get(uri);
  //   debugPrint(response.body);
  //   List<CardModel> tempdata = cardModelFromJson(response.body);
  //   setState(() {
  //     card = tempdata;
  //     loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name}'),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Text('${widget.id}'),
          Container(
            // padding: const EdgeInsets.all(5),
            // Data Table logic and code is in DataClass
              height: 700,
              child:
              // DataClass(datalist: card)
              TourPlayerCards(id: widget.id, tour_id: widget.tour_id)),
          // SizedBox(height:10),

        ],
      ),
    );
  }
}


class TourPlayerCards extends StatefulWidget {
  /// Creates the home page.
  final id;
  final tour_id;
  TourPlayerCards({Key? key, required this.id, required this.tour_id}) : super(key: key);



  @override
  _TourPlayerCards createState() => _TourPlayerCards();
}

class _TourPlayerCards extends State<TourPlayerCards> {
  // List<Employee> employees = <Employee>[];
  // List<CardModel> data;
  // late EmployeeDataSource employeeDataSource;
  late _JsonDataGridSourceTourPlayerCards jsonDataGridSourceTourPlayerCards;
  List<TourPlayersCardModel> card = [];
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // debugPrint(widget.id);
    final uri = Uri.http('www.golfoneclub.com', '/api/tour/players/cards', {
      'playerProfileId': widget.id,
      'tour_id': widget.tour_id
    } .map((key, value) => MapEntry(key, value.toString())));
    print(uri);
    http.Response response = await http.get(uri);
    print(response.body);
    // // print('Pepi');
    // // List<CardModel> tempdata = cardModelFromJson(response.body);
    // // jsonDataGridSource = _JsonDataGridSource(tempdata);
    // // print(tempdata);
    // // return tempdata;
    var list = json.decode(response.body).cast<Map<String, dynamic>>();
    print(list);
    fields = ['Date', 'Course Name', 'Strokes', 'Score', 'Points'];
    print('pescau');
    // List<TourPlayersCard> card = tourPlayersCardFromJson(response.body);
    print(list.map<TourPlayersCardModel>((json) => TourPlayersCardModel.fromJson(json)).toList());
    card = list.map<TourPlayersCardModel>((json) => TourPlayersCardModel.fromJson(json)).toList();
    // print('catando');

    // print(fields);

    // print(card);
    // print(list[0].keys);

    jsonDataGridSourceTourPlayerCards = _JsonDataGridSourceTourPlayerCards(card);

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
          print(snapshot.hasData);
          print(fields);
          return snapshot.hasData
              ? SfDataGrid(
            // return SfDataGrid(
              source: jsonDataGridSourceTourPlayerCards,
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
        });
  }
}


class _JsonDataGridSourceTourPlayerCards extends DataGridSource {
  _JsonDataGridSourceTourPlayerCards(this.productlist) {
    buildDataGridRow();
  }

  late List<DataGridRow> dataGridRows = [];
  late List<TourPlayersCardModel> productlist = [];




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
            return null;
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
        DataGridCell(columnName: 'Date', value:  '${dataGridRow.date.month}/${dataGridRow.date.day}/${dataGridRow.date.year}'),
        DataGridCell(
            columnName: 'Course Name', value: dataGridRow.courseName.toString()),
        DataGridCell(
            columnName: 'Strokes', value: dataGridRow.strokes.toString()),
        DataGridCell(
            columnName: 'Score', value: dataGridRow.score.toString()),
        DataGridCell(columnName: 'Points', value: dataGridRow.points.toString()),
        // DataGridCell(columnName: '5', value: dataGridRow.the5),
        // DataGridCell(columnName: '6', value: dataGridRow.the6),
        // DataGridCell(columnName: '7', value: dataGridRow.the7),
        // DataGridCell(columnName: '8', value: dataGridRow.the8),
        // DataGridCell(columnName: '9', value: dataGridRow.the9),
        // DataGridCell(columnName: 'IN', value: dataGridRow.cardModelIn),
        // DataGridCell(columnName: '10', value: dataGridRow.the10),
        // DataGridCell(columnName: '11', value: dataGridRow.the11),
        // DataGridCell(columnName: '12', value: dataGridRow.the12),
        // DataGridCell(columnName: '13', value: dataGridRow.the13),
        // DataGridCell(columnName: '14', value: dataGridRow.the14),
        // DataGridCell(columnName: '15', value: dataGridRow.the15),
        // DataGridCell(columnName: '16', value: dataGridRow.the16),
        // DataGridCell(columnName: '17', value: dataGridRow.the17),
        // DataGridCell(columnName: '18', value: dataGridRow.the18),
        // DataGridCell(columnName: 'OUT', value: dataGridRow.out),
      ]);
    }).toList(growable: false);
  }
}


class NewTour extends StatefulWidget {
  // final List<ScorecardsModel> data;
  // final id;
  final id;
  // final tour_id;
  final String title;

  // const ProductDetail({Key? key, this.id = '1'}) : super(key: key);
  // final String card_id;
  // final String name;

  static const String route = '/tour/detail';
  const NewTour({Key? key, required this.title, required this.id}) : super(key: key);
  // static const String route = '/';



  @override
  State<NewTour> createState() => _NewTour();
}

class _NewTour extends State<NewTour> {

  List<CardModel> card=[];
  bool loading = true;
  List<FriendsModel> _animals = [];
  List<FriendsModel> _animals_info = [];
  List<FriendsModel> _members = [];
  List<MultiSelectItem<Object?>> _items = [];
  String tour_name = '';
  var tour_name_initial = null;
  var tour_min_members_initial = null;
  var members_initial = [];
  var min_members;
  var data = [];
  List _selectedAnimals =[];


  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // debugPrint(widget.id);
    final uri = Uri.http('www.golfoneclub.com', '/api/friends', {
      'playerProfileId': prefs.getInt('playerProfileId'),
      // 'tour_id': widget.tour_id
    } .map((key, value) => MapEntry(key, value.toString())));
    print(uri);
    http.Response response = await http.get(uri);
    print(response.body);
    // // print('Pepi');
    // // List<CardModel> tempdata = cardModelFromJson(response.body);
    // // jsonDataGridSource = _JsonDataGridSource(tempdata);
    // // print(tempdata);
    // // return tempdata;
    var list = json.decode(response.body).cast<Map<String, dynamic>>();

    // List<TourPlayersCard> card = tourPlayersCardFromJson(response.body);
    _animals = list.map<FriendsModel>((json) => FriendsModel.fromJson(json)).toList();
    print(_animals);
    _selectedAnimals.add(FriendsModel(id: prefs.getInt('playerProfileId'), name: prefs.getString('name') ?? ''));
    //
    print(_selectedAnimals);

    // return card;
    setState(() {
      _items = _animals
          .map((animal) => MultiSelectItem<FriendsModel>(animal, animal.name ?? ''))
          .toList();

    });
  }




  Future getTourInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // debugPrint(widget.id);
    final uri = Uri.http('www.golfoneclub.com', '/api/tour/info', {
      'playerProfileId': prefs.getInt('playerProfileId'),
      'tour_id': widget.id
    } .map((key, value) => MapEntry(key, value.toString())));
    print(uri);
    http.Response response = await http.get(uri);
    print(response.body);
    data = json.decode(response.body).cast<Map<String, dynamic>>();
    print(data[0]);
    print(data[0]['members']);
    // _animals_info = data[0]['members'].map<FriendsModel>((json) => FriendsModel.fromJson(json)).toList();

    // List<CardModel> tempdata = cardModelFromJson(response.body);
    // setState(() {
    //   _animals_info = data[0]['members'].map<FriendsModel>((json) => FriendsModel.fromJson(json)).toList();
    //   // tour_min_members_initial = double.parse(data[0]['min_members']);
    //   // members_initial = data[0]['members'];
    // });
    return data;
  }

  @override
  void initState() {
    super.initState();
    // _addScrollListener();
    // if (widget.id != Null) {
    //   getTourInfo();
    // }
    getData();

  }

  @override
  Widget build(BuildContext context) {
    if (widget.id == Null) {
      DateTimeRange selectedDates = DateTimeRange(start: DateTime.now(), end: DateTime.now());
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text('Tour Name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: HexColor("#009B77")
                  ),),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    initialValue: tour_name_initial,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'Tour name'),
                    // validator: ,
                    onChanged: (value) {
                      setState(() {
                        tour_name = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text('Tour members',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: HexColor("#009B77")
                  ),),
                SizedBox(height: 10),
                MultiSelectDialogField(
                  items: _items,
                  initialValue: [],
                  title: Text("Choose tour members"),
                  selectedColor: HexColor("#009B77"),
                  decoration: BoxDecoration(
                    color: HexColor("#009B77").withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      color: HexColor("#009B77"),
                      width: 2,
                    ),
                  ),
                  buttonIcon: Icon(
                    Icons.add,
                    color: HexColor("#009B77"),
                  ),
                  buttonText: Text(
                    "Add Friends",
                    style: TextStyle(
                      color: HexColor("#009B77"),
                      fontSize: 16,
                    ),
                  ),
                  onConfirm: (results) {
                    print(results);
                    _selectedAnimals = results;
                  },
                ),
                SizedBox(height: 10),
                Text('Tour Timeframe',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: HexColor("#009B77")
                  ),),
                Center(
                    child:
                    // OutlinedButton(
                    //   onPressed: () {
                    //     _restorableDateRangePickerRouteFuture.present();
                    //   },
                    //   child: const Text('Select Tour Timeframe'),
                    // ),
                    Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${selectedDates.start.month}/${selectedDates
                                  .start.day}/${selectedDates.start.year}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  // color: HexColor('#009B77')
                                ),),
                              Icon(Icons.arrow_right),
                              Text(
                                '${selectedDates.end.month}/${selectedDates.end
                                    .day}/${selectedDates.end.year}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  // color: HexColor('#009B77')
                                ),)
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                              InkWell(
                                onTap: () async {
                                  final DateTimeRange? dateTimeRange = await showDateRangePicker(
                                      context: context, firstDate: DateTime(
                                      2020), lastDate: DateTime(2030));
                                  if (dateTimeRange != null) {
                                    setState(() {
                                      selectedDates = dateTimeRange;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  color: HexColor("#009B77"),
                                  child: Center(child: Text(
                                    'Select Timeframe', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: HexColor('#FCE300')
                                  ),)),
                                ),)
                          ),
                        ])
                ),
                // Container(
                //   height: 100,
                // child: ElevatedButton(
                //   child: Text("choose dates"),
                //   onPressed: () async {
                //     final DateTimeRange? dateTimeRange = await showDateRangePicker(context: context, firstDate: DateTime(2020), lastDate: DateTime(2030));
                //     if (dateTimeRange != null) {
                //       setState(() {
                //         selectedDates = dateTimeRange;
                //       });
                //     }
                //   },
                // )
                // ),
                Text('Minumum number of players in event',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: HexColor("#009B77")
                  ),),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Number of players'),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      setState(() {
                        min_members = value;
                      });
                    },
                  ),
                ),
                Center(
                  child:
                  // OutlinedButton(
                  //   onPressed: () {
                  //     _restorableDateRangePickerRouteFuture.present();
                  //   },
                  //   child: const Text('Select Tour Timeframe'),
                  // ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      InkWell(
                        onTap: () async {
                          // _restorableDateRangePickerRouteFuture.present();
                          print(tour_name);
                          if (tour_name == null || tour_name == '') {
                            EasyLoading.showError("Tour name is missing");
                          }
                          else if (_selectedAnimals.length <= 1) {
                            EasyLoading.showError("Missing tour members");
                          }
                          else if (selectedDates.start == selectedDates.end) {
                            EasyLoading.showError("Missing tour timeframe");
                          }
                          else if (min_members == null || min_members == '') {
                            EasyLoading.showError(
                                "Mininum numbers of users to be considered a tour event is missing");
                          }
                          else {
                            var members = _selectedAnimals.map((e) =>
                                e.id.toString()).toList();
                            print(members);
                            final uri = Uri.http(
                                'www.golfoneclub.com', '/api/tour/new', {
                              'tour_name': tour_name,
                              'min_members': min_members,
                              'tour_start': selectedDates.start.toString(),
                              'tour_end': selectedDates.end.toString(),
                              'tour_members': members,
                            });
                            print(uri);
                            http.Response response = await http.get(uri);
                            debugPrint(response.body);
                            if (response.statusCode == 200) {
                              print(jsonDecode(response.body));
                              var json = jsonDecode(response.body);
                              await EasyLoading.showSuccess('Tour Started');
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Tour()));
                            } else {
                              EasyLoading.showError('Error creating tour');
                            }
                          }


                          print(min_members);
                          print(selectedDates);
                          print(_selectedAnimals);
                        },
                        child: Container(
                          height: 50,
                          color: HexColor("#009B77"),
                          child: Center(
                              child: Text('START TOUR', style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: HexColor('#FCE300')
                              ),)),
                        ),)
                  ),
                )
                // Text('${widget.id}'),
                // DateRangeField(
                //   decoration: InputDecoration(
                //     label: Text("Date range picker"),
                //     hintText: 'Please select a date range',
                //   ),
                //   onDateRangeSelected: (DateRange? value) {
                //     // Handle the selected date range here
                //   },
                //   selectedDateRange: selectedRange,
                // ),
                // Container(
                //   // padding: const EdgeInsets.all(5),
                //   // Data Table logic and code is in DataClass
                //     height: 700,
                //     // child:
                //     // // DataClass(datalist: card)
                //     // TourPlayerCards(id: widget.id, tour_id: widget.tour_id)
                // ),
                // SizedBox(height:10),
              ])
      );
    } else {

      return FutureBuilder(
          future: getTourInfo(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print(snapshot.hasData);
            if (snapshot.hasData) {
              DateTimeRange selectedDates = DateTimeRange(
                  start: DateTime.parse(data[0]['start']),
                  end: DateTime.parse(data[0]['end']));
              // var members = data[0]['members'];
              // List<FriendsModel> _members = data[0]['members'].map<FriendsModel>((json) =>
              //     FriendsModel.fromJson(json)).toList();
              List<FriendsModel> _friends = data[0]['friends'].map<FriendsModel>((json) =>
                  FriendsModel.fromJson(json)).toList();
              for (var elem in _members) {_friends.remove(elem);}
              var _items2 = _friends
                  .map((animal) => MultiSelectItem<FriendsModel>(animal, animal.name ?? ''))
                  .toList();
              tour_name = data[0]['name'];
              min_members = data[0]['min_members'];
              _selectedAnimals = _friends.take(data[0]['members']).toList();

              return Scaffold(
                // return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.title),
                  ),
                  body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text('Tour Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: HexColor("#009B77")
                          ),),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            initialValue: data[0]['name'],
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(hintText: 'Tour name'),
                            // validator: ,
                            onChanged: (value) {
                              setState(() {
                                tour_name = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Tour members',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: HexColor("#009B77")
                          ),),
                        SizedBox(height: 10),
                        MultiSelectDialogField(
                          items: _items2,
                          initialValue: _friends.take(data[0]['members']).toList(),
                          searchable: true,
                          title: Text("Choose tour members"),
                          selectedColor: HexColor("#009B77"),
                          decoration: BoxDecoration(
                            color: HexColor("#009B77").withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: HexColor("#009B77"),
                              width: 2,
                            ),
                          ),
                          buttonIcon: Icon(
                            Icons.add,
                            color: HexColor("#009B77"),
                          ),
                          buttonText: Text(
                            "Add Friends",
                            style: TextStyle(
                              color: HexColor("#009B77"),
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            print(results);
                            _selectedAnimals = results;
                          },
                        ),
                        SizedBox(height: 10),
                        Text('Tour Timeframe',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: HexColor("#009B77")
                          ),),
                        Center(
                            child:
                            // OutlinedButton(
                            //   onPressed: () {
                            //     _restorableDateRangePickerRouteFuture.present();
                            //   },
                            //   child: const Text('Select Tour Timeframe'),
                            // ),
                            Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${selectedDates.start
                                          .month}/${selectedDates
                                          .start.day}/${selectedDates.start
                                          .year}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          // color: HexColor('#009B77')
                                        ),),
                                      Icon(Icons.arrow_right),
                                      Text(
                                        '${selectedDates.end
                                            .month}/${selectedDates.end
                                            .day}/${selectedDates.end.year}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          // color: HexColor('#009B77')
                                        ),)
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                      InkWell(
                                        onTap: () async {
                                          final DateTimeRange? dateTimeRange = await showDateRangePicker(
                                              context: context,
                                              firstDate: DateTime(
                                                  2020),
                                              lastDate: DateTime(2030));
                                          if (dateTimeRange != null) {
                                            setState(() {
                                              selectedDates = dateTimeRange;
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          color: HexColor("#009B77"),
                                          child: Center(child: Text(
                                            'Select Timeframe',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: HexColor('#FCE300')
                                            ),)),
                                        ),)
                                  ),
                                ])
                        ),
                        // Container(
                        //   height: 100,
                        // child: ElevatedButton(
                        //   child: Text("choose dates"),
                        //   onPressed: () async {
                        //     final DateTimeRange? dateTimeRange = await showDateRangePicker(context: context, firstDate: DateTime(2020), lastDate: DateTime(2030));
                        //     if (dateTimeRange != null) {
                        //       setState(() {
                        //         selectedDates = dateTimeRange;
                        //       });
                        //     }
                        //   },
                        // )
                        // ),
                        Text('Minumum number of players in event',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: HexColor("#009B77")
                          ),),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: TextFormField(
                            initialValue: data[0]['min_members'].toString(),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: 'Number of players'),
                            // keyboardType: TextInputType.number,
                            // inputFormatters: <TextInputFormatter>[
                            //   FilteringTextInputFormatter.digitsOnly
                            // ],
                            onChanged: (value) {
                              setState(() {
                                min_members = value;
                              });
                            },
                          ),
                        ),
                        Center(
                          child:
                          // OutlinedButton(
                          //   onPressed: () {
                          //     _restorableDateRangePickerRouteFuture.present();
                          //   },
                          //   child: const Text('Select Tour Timeframe'),
                          // ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                              InkWell(
                                onTap: () async {
                                  // _restorableDateRangePickerRouteFuture.present();
                                  print(tour_name);
                                  if (tour_name == null || tour_name == '') {
                                    EasyLoading.showError(
                                        "Tour name is missing");
                                  }
                                  else if (_selectedAnimals.length <= 1) {
                                    EasyLoading.showError(
                                        "Missing tour members");
                                  }
                                  else if (selectedDates.start ==
                                      selectedDates.end) {
                                    EasyLoading.showError(
                                        "Missing tour timeframe");
                                  }
                                  else if (min_members == null ||
                                      min_members == '') {
                                    EasyLoading.showError(
                                        "Mininum numbers of users to be considered a tour event is missing");
                                  }
                                  else {
                                    var members = _selectedAnimals.map((e) =>
                                        e.id.toString()).toList();
                                    print(members);
                                    final uri = Uri.http(
                                        'www.golfoneclub.com', '/api/tour/update',
                                        {
                                          'tour_id': widget.id.toString(),
                                          'tour_name': tour_name.toString(),
                                          'min_members': min_members.toString(),
                                          'tour_start': selectedDates.start
                                              .toString(),
                                          'tour_end': selectedDates.end
                                              .toString(),
                                          'tour_members': members,
                                        });
                                    print(uri);
                                    http.Response response = await http.get(
                                        uri);
                                    debugPrint(response.body);
                                    if (response.statusCode == 200) {
                                      print(jsonDecode(response.body));
                                      var json = jsonDecode(response.body);
                                      await EasyLoading.showSuccess(
                                          'Tour Updated');
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => Tour()));
                                    } else {
                                      EasyLoading.showError(
                                          'Error updating tour');
                                    }
                                  }


                                  print(min_members);
                                  print(selectedDates);
                                  print(_selectedAnimals);
                                },
                                child: Container(
                                  height: 50,
                                  color: HexColor("#009B77"),
                                  child: Center(
                                      child: Text(
                                        'UPDATE TOUR', style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: HexColor('#FCE300')
                                      ),)),
                                ),)
                          ),
                        )
                        // Text('${widget.id}'),
                        // DateRangeField(
                        //   decoration: InputDecoration(
                        //     label: Text("Date range picker"),
                        //     hintText: 'Please select a date range',
                        //   ),
                        //   onDateRangeSelected: (DateRange? value) {
                        //     // Handle the selected date range here
                        //   },
                        //   selectedDateRange: selectedRange,
                        // ),
                        // Container(
                        //   // padding: const EdgeInsets.all(5),
                        //   // Data Table logic and code is in DataClass
                        //     height: 700,
                        //     // child:
                        //     // // DataClass(datalist: card)
                        //     // TourPlayerCards(id: widget.id, tour_id: widget.tour_id)
                        // ),
                        // SizedBox(height:10),
                      ])
              );
            } else {
            return Scaffold(
                body: Center(
            child: CircularProgressIndicator(
            strokeWidth: 3,
            )
            ,
            // child: Text('Pollon'),
            ));
          }
            // return SfDataGrid(
            //     source: jsonDataGridSource,
            //     columns: getColumns()
            // );

          });
    }
  }
}

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _DatePickerExampleState extends State<DatePickerExample>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime.now());
  final RestorableDateTimeN _endDate =
  RestorableDateTimeN(DateTime.now().add(Duration(days: 5)));
  late final RestorableRouteFuture<DateTimeRange?>
  _restorableDateRangePickerRouteFuture =
  RestorableRouteFuture<DateTimeRange?>(
    onComplete: _selectDateRange,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator
          .restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
        'initialStartDate': _startDate.value?.millisecondsSinceEpoch,
        'initialEndDate': _endDate.value?.millisecondsSinceEpoch,
      });
    },
  );

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;
      });
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_startDate, 'start_date');
    registerForRestoration(_endDate, 'end_date');
    registerForRestoration(
        _restorableDateRangePickerRouteFuture, 'date_picker_route_future');
  }

  @pragma('vm:entry-point')
  static Route<DateTimeRange?> _dateRangePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTimeRange?>(
      context: context,
      builder: (BuildContext context) {
        return DateRangePickerDialog(
          restorationId: 'date_picker_dialog',
          initialDateRange:
          _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
          firstDate: DateTime(2021),
          currentDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 1095)),
        );
      },
    );
  }

  static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
    if (arguments['initialStartDate'] != null &&
        arguments['initialEndDate'] != null) {
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialStartDate'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialEndDate'] as int),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        // OutlinedButton(
        //   onPressed: () {
        //     _restorableDateRangePickerRouteFuture.present();
        //   },
        //   child: const Text('Select Tour Timeframe'),
        // ),
        Padding(
        padding: const EdgeInsets.all(8.0),
    child:
          InkWell(
            onTap: () {
              _restorableDateRangePickerRouteFuture.present();
            },
            child: Container(
              height: 50,
              color: HexColor("#009B77"),
              child:  Center(child: Text('Select Tour Timeframe', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: HexColor('#FCE300')
              ),)),
            ),)
      ),
      )
    );
  }
}