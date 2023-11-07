

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oneclubmobile/views/scorecards.dart';
import 'package:oneclubmobile/views/landing.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:oneclubmobile/models/chart_models.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math';
import 'package:oneclubmobile/views/search_friends.dart';
import 'package:oneclubmobile/views/tour.dart';


// void main() {
//   runApp(const MyApp());
// }

class MyAppFinal extends StatelessWidget {
  const MyAppFinal({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BottomNavbar Demo',
        // theme: ThemeData(
        //   // colorScheme: ColorScheme.fromSeed(seedColor: HexColor("#174038")),
        //   // primarySwatch: Colors.indigo,
        // ),
        routes: {
          // This route needs to be registered, Because
          //  we are pushing this on the main Navigator Stack on line 754 (isRootNavigator:true)
          ProfileEdit.route: (context) => const ProfileEdit(),
        },
        home: const NavBarHandler());
  }
}

class MenuItem {
  const MenuItem(this.iconData, this.text);
  final IconData iconData;
  final String text;
}

Future<void> navigate(BuildContext context, String route,
    {bool isDialog = false,
      bool isRootNavigator = true,
      Map<String, dynamic>? arguments}) =>
    Navigator.of(context, rootNavigator: isRootNavigator)
        .pushNamed(route, arguments: arguments);

final homeKey = GlobalKey<NavigatorState>();
final productsKey = GlobalKey<NavigatorState>();
final profileKey = GlobalKey<NavigatorState>();
final NavbarNotifier _navbarNotifier = NavbarNotifier();
List<Color> colors = [HexColor("#174038"), HexColor("#174038"), HexColor("#174038")];
const Color mediumPurple = Color.fromRGBO(79, 0, 241, 1.0);
const String placeHolderText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

class NavBarHandler extends StatefulWidget {
  const NavBarHandler({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<NavBarHandler> createState() => _NavBarHandlerState();
}

class _NavBarHandlerState extends State<NavBarHandler>
    with SingleTickerProviderStateMixin {
  final _buildBody = const <Widget>[HomeMenu(), ProductsMenu(), ProfileMenu()];

  late List<BottomNavigationBarItem> _bottomList = <BottomNavigationBarItem>[];

  final menuItemlist = const <MenuItem>[
    MenuItem(Icons.home, 'Home'),
    MenuItem(Icons.scoreboard, 'Scorecards'),
    MenuItem(Icons.more_horiz, 'More'),
  ];

  late Animation<double> fadeAnimation;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    fadeAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    _bottomList = List.generate(
        _buildBody.length,
            (index) => BottomNavigationBarItem(
          icon: Icon(menuItemlist[index].iconData),
          label: menuItemlist[index].text,
        )).toList();
    _controller.forward();
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 600),
        margin: EdgeInsets.only(
            bottom: kBottomNavigationBarHeight, right: 2, left: 2),
        content: Text('Tap back button again to exit'),
      ),
    );
  }

  void hideSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DateTime oldTime = DateTime.now();
  DateTime newTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool isExitingApp = await _navbarNotifier.onBackButtonPressed();
        if (isExitingApp) {
          newTime = DateTime.now();
          int difference = newTime.difference(oldTime).inMilliseconds;
          oldTime = newTime;
          if (difference < 1000) {
            hideSnackBar();
            return isExitingApp;
          } else {
            showSnackBar();
            return false;
          }
        } else {
          return isExitingApp;
        }
      },
      child: Material(
        child: AnimatedBuilder(
            animation: _navbarNotifier,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  IndexedStack(
                    index: _navbarNotifier.index,
                    children: [
                      for (int i = 0; i < _buildBody.length; i++)
                        FadeTransition(
                            opacity: fadeAnimation, child: _buildBody[i])
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedNavBar(
                        model: _navbarNotifier,
                        onItemTapped: (x) {
                          // User pressed  on the same tab twice
                          if (_navbarNotifier.index == x) {
                            _navbarNotifier.popAllRoutes(x);
                          } else {
                            _navbarNotifier.index = x;
                            _controller.reset();
                            _controller.forward();
                          }
                        },
                        menuItems: menuItemlist),
                  ),
                ],
              );
            }),
      ),
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

class AnimatedNavBar extends StatefulWidget {
  const AnimatedNavBar(
      {Key? key,
        required this.model,
        required this.menuItems,
        required this.onItemTapped})
      : super(key: key);
  final List<MenuItem> menuItems;
  final NavbarNotifier model;
  final Function(int) onItemTapped;

  @override
  _AnimatedNavBarState createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar>
    with SingleTickerProviderStateMixin {
  @override
  void didUpdateWidget(covariant AnimatedNavBar oldWidget) {
    if (widget.model.hideBottomNavBar != isHidden) {
      if (!isHidden) {
        _showBottomNavBar();
      } else {
        _hideBottomNavBar();
      }
      isHidden = !isHidden;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _hideBottomNavBar() {
    _controller.reverse();
    return;
  }

  void _showBottomNavBar() {
    _controller.forward();
    return;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 100.0).animate(_controller);
  }

  late AnimationController _controller;
  late Animation<double> animation;
  bool isHidden = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(0, animation.value),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(2, -2),
                ),
              ]),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                currentIndex: widget.model.index,
                onTap: (x) {
                  widget.onItemTapped(x);
                },
                elevation: 16.0,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.white54,
                selectedItemColor: Colors.white,
                items: widget.menuItems
                    .map((MenuItem menuItem) => BottomNavigationBarItem(
                  backgroundColor: colors[widget.model.index],
                  icon: Icon(menuItem.iconData),
                  label: menuItem.text,
                ))
                    .toList(),
              ),
            ),
          );
        });
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(primary: colors[0])),
      child: Navigator(
          key: homeKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const HomeFeeds();
                break;
              case FeedDetail.route:
                builder = (BuildContext _) {
                  final id = (settings.arguments as Map)['id'];
                  return FeedDetail(
                    feedId: id,
                  );
                };
                break;
              default:
                builder = (BuildContext _) => const HomeFeeds();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          }),
    );
  }
}

class ProductsMenu extends StatefulWidget {
  const ProductsMenu({Key? key}) : super(key: key);

  @override
  State<ProductsMenu> createState() => _ProductsMenu();
}
class _ProductsMenu extends State<ProductsMenu> {

  List<ScorecardsModel> scorecards=[];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.http('www.golfoneclub.com', '/api/landing/scorecards', {
      'playerProfileId': prefs.getInt('playerProfileId'),
    } .map((key, value) => MapEntry(key, value.toString())));
    http.Response response = await http.get(uri);
    debugPrint(response.body);
    List<ScorecardsModel> tempdata = scorecardsModelFromJson(response.body);
    setState(() {
      scorecards = tempdata;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(primary: colors[1])),
      child: Navigator(
          key: productsKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => ProductList(data: scorecards,);
                break;
              case ProductDetail.route:
                final id = (settings.arguments as Map)['id'];
                builder = (BuildContext _) {
                  return ProductDetail(
                    id: id,
                  );
                };
                break;
              case ProductComments.route:
                final id = (settings.arguments as Map)['id'];
                builder = (BuildContext _) {
                  return ProductComments(
                    id: id,
                  );
                };
                break;
              case ProductRoundStats.route:
                final id = (settings.arguments as Map)['id'];
                builder = (BuildContext _) {
                  return ProductRoundStats(
                    id: id,
                  );
                };
                break;
              default:
                builder = (BuildContext _) => ProductList(data: scorecards,);
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          }),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(primary: colors[2])),
      child: Navigator(
          key: profileKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const UserProfile();
                break;
              case ProfileEdit.route:
                builder = (BuildContext _) => const ProfileEdit();
                break;
              default:
                builder = (BuildContext _) => const UserProfile();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          }),
    );
  }
}

class HomeFeeds extends StatefulWidget {
  const HomeFeeds({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<HomeFeeds> createState() => _HomeFeedsState();
}

class _HomeFeedsState extends State<HomeFeeds> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
  }

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeds'),
      ),
      body: DashboardScreen(),
      // ListView.builder(
      //   controller: _scrollController,
      //   itemCount: 30,
      //   itemBuilder: (context, index) {
      //     return InkWell(
      //         onTap: () {
      //           _navbarNotifier.hideBottomNavBar = false;
      //           navigate(context, FeedDetail.route,
      //               isRootNavigator: false,
      //               arguments: {'id': index.toString()});
      //         },
      //         child: FeedTile(index: index));
      //   },
      // ),
    );
  }
}

class FeedTile extends StatelessWidget {
  final int index;
  const FeedTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      color: Colors.grey.withOpacity(0.4),
      child: Stack(
        children: [
          Positioned(
            top: 4,
            right: 4,
            left: 4,
            child: Container(
              color: Colors.grey,
              height: 180,
            ),
          ),
          Positioned(
              bottom: 12,
              right: 12,
              left: 12,
              child: Text(placeHolderText.substring(0, 200)))
        ],
      ),
    );
  }
}

class FeedDetail extends StatelessWidget {
  final String feedId;
  const FeedDetail({Key? key, this.feedId = '1'}) : super(key: key);
  static const String route = '/feeds/detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed $feedId'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Placeholder(
                fallbackHeight: 200,
                fallbackWidth: 300,
              ),
              Text(placeHolderText),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  final List<ScorecardsModel> data;
  const ProductList({Key? key, required this.data}) : super(key: key);
  static const String route = '/';



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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scorecards'),
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            final card = widget.data[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    _navbarNotifier.hideBottomNavBar = false;
                    navigate(context, ProductDetail.route,
                        isRootNavigator: false,
                        arguments: {'id': card.cardId
                          // , 'card_id': widget.data.single.cardId, 'name': 'pe'
                    });
                  },
                  child: ProductTile(index: index, data: card)),
            );
          }),
    );
  }
}

class ProductTile extends StatelessWidget {
  final int index;
  final ScorecardsModel data;
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
              child: Text('${data.score}', style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),),
            ),
    Flexible(
    child: Padding(
    padding: const EdgeInsets.only(left: 16.0),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.ltr,
            children: [
                Text('${data.courseName}',
                  // overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: HexColor('#009B77'),
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),
    Text('${data.startTime.month}/${data.startTime.day}/${data.startTime.year}', style: TextStyle(
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
  final String id;

  // const ProductDetail({Key? key, this.id = '1'}) : super(key: key);
  // final String card_id;
  // final String name;

  static const String route = '/products/detail';
  const ProductDetail({Key? key, required this.id}) : super(key: key);
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
        // title: Text('${widget.id}'),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Text('My AWESOME Product ${card.length}',),
        Container(
        // padding: const EdgeInsets.all(5),
        // Data Table logic and code is in DataClass
          height: 400,
        child:
        // DataClass(datalist: card)
            ScorecardTable(id: widget.id)),


          // const Center(
          //   child: Placeholder(
          //     fallbackHeight: 200,
          //     fallbackWidth: 300,
          //   ),
          // ),

          FilledButton(
              onPressed: () {
                _navbarNotifier.hideBottomNavBar = false;
                navigate(context, ProductComments.route,
                    isRootNavigator: false, arguments: {'id': widget.id.toString()});
              },
              child: const Text('Holes')),
          FilledButton(
              onPressed: () {
                _navbarNotifier.hideBottomNavBar = false;
                navigate(context, ProductRoundStats.route,
                    isRootNavigator: false, arguments: {'id': widget.id.toString()});
              },
              child: const Text('Round Stats'))
        ],
      ),
    );
  }
}

// class ProductComments extends StatelessWidget {
//   final String id;
//   const ProductComments({Key? key, this.id = '1'}) : super(key: key);
//   static const String route = '/products/detail/comments';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Comments on Product $id'),
//       ),
//       body: ListView.builder(itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SizedBox(
//             height: 60,
//             child: ListTile(
//               tileColor: Colors.grey.withOpacity(0.5),
//               title: Text('Comment $index'),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }


class ProductRoundStats extends StatefulWidget {
  // const MapScreen({super.key});
  final id;
  // final hole;
  static const String route = '/products/detail/roundstats';
  ProductRoundStats({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductRoundStats> createState() => _ProductRoundStats();
}

class _ProductRoundStats extends State<ProductRoundStats> {
  // final String id;
  // const ProductComments({Key? key, this.id = '1'}) : super(key: key);
  var fields = [];
  var list;
  var colors;
  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint(widget.id);
    final uri = Uri.http('www.golfoneclub.com', '/api/landing/card/roundstats', {
      'playerProfileId': prefs.getInt('playerProfileId'),
      'card_id': widget.id,
      'unit': prefs.getString('unit')
    } .map((key, value) => MapEntry(key, value.toString())));
    print(uri);
    http.Response response = await http.get(uri);
    debugPrint(response.body);
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

      marks.add(LinearWidgetPointer(
        value: key.value.toDouble(),
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
    if (['GIR', 'Fairway Hit', 'Driver Avg', 'Driver Max', 'Up & Down'].contains(widget.title)) {
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
        ],

    );
  }
}



class ProductComments extends StatefulWidget {
  // const MapScreen({super.key});
  final id;
  // final hole;
  static const String route = '/products/detail/comments';
  ProductComments({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductComments> createState() => _ProductComments();
}

class _ProductComments extends State<ProductComments> {
  // final String id;
  // const ProductComments({Key? key, this.id = '1'}) : super(key: key);


  int _hole = 1;
  MapScreen? map;
  Future<void>  _incrementCounter() async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _hole++;
      if (_hole == 19){
        _hole = 1;
      }
      map = MapScreen(id: widget.id, hole: _hole,);
    });
  }

  Future<void>  _decrementCounter() async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _hole--;
      if (_hole == 0){
        _hole = 18;
      }
      map = MapScreen(id: widget.id, hole: _hole,);
    });
  }

  @override
  void initState() {
    // getCurrentLocation();
    super.initState();
    // getData();
    map = MapScreen(id: widget.id, hole: _hole,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_hole}'),
      ),
      body: map,
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
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: Icon(
                  Icons.arrow_left
              ),
              onPressed: () {
               _decrementCounter();
              },
              heroTag: null,
              backgroundColor: HexColor('#009B77'),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              child: Icon(
                  Icons.arrow_right,

              ),
              onPressed: () => _incrementCounter(),
              heroTag: null,
              backgroundColor: HexColor('#009B77'),
            )
          ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    //   FloatingActionButton(
    //   onPressed: _incrementCounter,
    //   tooltip: 'Increment',
    //   child: Icon(Icons.add),
    // ),
    );
  }
}


class UserProfile extends StatelessWidget {
  static const String route = '/';

  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                navigate(context, ProfileEdit.route);
              },
            )
          ],
          title: const Text('Hi User')),
      body:  Center(
        child:


                ListView(
                    // controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    // Container(
                    //   height: 50,
                    //   color: Colors.amber[600],
                    //   child: const Center(child: Text('Entry A')),
                    // ),
                        InkWell(
                            onTap: () {
                              _navbarNotifier.hideBottomNavBar = false;
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(title: 'Search Friends',)));
                              // navigate(context, ProductDetail.route,
                              //     isRootNavigator: false,
                              //     arguments: {'id': card.cardId
                              //       // , 'card_id': widget.data.single.cardId, 'name': 'pe'
                              //     });
                            },
                            child: Container(
                              height: 50,
                              color: HexColor("#009B77"),
                              child:  Center(child: Text('Buddies', style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: HexColor('#FCE300')
                              ),)),
                            ),),
                    SizedBox(height:10),
                    InkWell(
                      onTap: () {
                        _navbarNotifier.hideBottomNavBar = false;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Tour()));
                        // navigate(context, ProductDetail.route,
                        //     isRootNavigator: false,
                        //     arguments: {'id': card.cardId
                        //       // , 'card_id': widget.data.single.cardId, 'name': 'pe'
                        //     });
                      },
                      child: Container(
                        height: 50,
                        color: HexColor("#009B77"),
                        child:  Center(child: Text('Tour', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: HexColor('#FCE300')
                        ),)),
                      ),),
                    SizedBox(height:10),
                    InkWell(
                      onTap: () {
                        _navbarNotifier.hideBottomNavBar = false;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(title: 'Search Friends',)));
                        // navigate(context, ProductDetail.route,
                        //     isRootNavigator: false,
                        //     arguments: {'id': card.cardId
                        //       // , 'card_id': widget.data.single.cardId, 'name': 'pe'
                        //     });
                      },
                      child: Container(
                        height: 50,
                        color: HexColor("#009B77"),
                        child:  Center(child: Text('Bag', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: HexColor('#FCE300')
                        ),)),
                      ),),
                    SizedBox(height:10),
                    InkWell(
                      onTap: () {
                        _navbarNotifier.hideBottomNavBar = false;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(title: 'Search Friends',)));
                        // navigate(context, ProductDetail.route,
                        //     isRootNavigator: false,
                        //     arguments: {'id': card.cardId
                        //       // , 'card_id': widget.data.single.cardId, 'name': 'pe'
                        //     });
                      },
                      child: Container(
                        height: 50,
                        color: HexColor("#009B77"),
                        child:  Center(child: Text('Courses', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: HexColor('#FCE300')
                        ),)),
                      ),),
                    SizedBox(height:10),
                    InkWell(
                      onTap: () {
                        _navbarNotifier.hideBottomNavBar = false;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(title: 'Search Friends',)));
                        // navigate(context, ProductDetail.route,
                        //     isRootNavigator: false,
                        //     arguments: {'id': card.cardId
                        //       // , 'card_id': widget.data.single.cardId, 'name': 'pe'
                        //     });
                      },
                      child: Container(
                        height: 50,
                        color: HexColor("#009B77"),
                        child:  Center(child: Text('Stats', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: HexColor('#FCE300')
                        ),)),
                      ),),

                    ]

                // Text('Hi My Name is'),
                // SizedBox(
                //   width: 10,
                // ),
                // SizedBox(
                //   width: 100,
                //   child: TextField(
                //     decoration: InputDecoration(),
                //   ),
                // ),
                )



      ),
    );
  }
}

class ProfileEdit extends StatelessWidget {
  static const String route = '/profile/edit';

  const ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Edit')),
      body: const Center(
        child: Text('Notice this page does not have bottom navigation bar'),
      ),
    );
  }
}