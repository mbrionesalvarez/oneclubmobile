import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key,required this.title}) : super(key: key);

  final String title;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? query;
  var playerProfileId;

  Future<List> searchFriends(String? query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.http('www.golfoneclub.com', '/api/users/available', {
      'playerProfileId': prefs.getInt('playerProfileId'),
      'name': query,
    } .map((key, value) => MapEntry(key, value.toString())));
    print(uri);
    final response = await http.get(uri);
    print(json.decode(response.body));
    List<AvailableFriends> tempdata = availableFriendsFromJson(response.body);
    playerProfileId = prefs.getInt('playerProfileId');
    return tempdata;
  }

  @override
  Widget build(BuildContext context) {
    // final api = Provider.of<ZomatoApi>(context);
    // final state = Provider.of<AppState>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
        //         Icons.tune,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SearchForm(
              onSearch: (q) {
                setState(() {
                  query = q;
                });
              },
            ),
            query == null
                ? Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black12,
                    size: 110,
                  ),
                  Text(
                    'No results to display',
                    style: TextStyle(
                      color: Colors.black12,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
                : FutureBuilder(
              future: searchFriends(query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                      child: Center(

                    child: CircularProgressIndicator(),
                  ));
                }

                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView(
                      children: snapshot.data?.map<Widget>(
                              (json) => RestaurantItem(restaurant: json, playerId: playerProfileId))
                          .toList() ?? [],
                    ),
                  );
                }

                return Text(
                    'Error retrieving results: ${snapshot.error}');
              },
            )
          ],
        ),
      ),
    );
  }
}



const double zMaxCount = 20;

class ZomatoApi {
  final double count = zMaxCount;

  final List<Category> categories = [];

  Future<List> searchRestaurants(String query, SearchOptions options) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.http('www.golfoneclub.com', '/api/landing/card/roundstats', {
      'playerProfileId': prefs.getInt('playerProfileId'),
      'name': query,
    } .map((key, value) => MapEntry(key, value.toString())));
    final response = await http.get(uri);
    return json.decode(response.body);
  }
}


List<AvailableFriends> availableFriendsFromJson(String str) => List<AvailableFriends>.from(json.decode(str).map((x) => AvailableFriends.fromJson(x)));

String availableFriendsToJson(List<AvailableFriends> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AvailableFriends {
  int id;
  String name;

  AvailableFriends({
    required this.id,
    required this.name,
  });

  AvailableFriends copyWith({
    int? id,
    String? name,
  }) =>
      AvailableFriends(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory AvailableFriends.fromJson(Map<String, dynamic> json) => AvailableFriends(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}


class Category {
  final int id;
  final String name;
  const Category(this.id, this.name);
}

class SearchOptions {

  double count;
  List<int> categories = [];

  SearchOptions({
    required this.count,
  });

  Map<String, dynamic> toJson() => {
    'count': count,
    'category': categories.join(',')
  };
}


class AppState {
  final SearchOptions searchOptions = SearchOptions(
    count: zMaxCount,
  );
}



class SearchForm extends StatefulWidget {
  SearchForm({required this.onSearch});

  final void Function(String search) onSearch;

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();

  var _autoValidate = false;
  var _search;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Enter search',
                border: OutlineInputBorder(borderSide: BorderSide(color: HexColor('#174038')),),
                labelStyle: TextStyle(color: HexColor('#174038')),
                filled: true,
                errorStyle: TextStyle(fontSize: 15, color: HexColor('#174038')),
              ),
              onChanged: (value) {
                _search = value;
              },
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return 'Please enter a search term';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                onPressed: () {
                  final isValid = _formKey.currentState?.validate() ?? false;
                  if (isValid) {
                    widget.onSearch(_search);
                    // Collapses keypad
                    FocusManager.instance.primaryFocus?.unfocus();
                  } else {
                    setState(() {
                      _autoValidate = true;
                    });
                  }
                },
                fillColor: HexColor('#174038'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantItem extends StatefulWidget {
  final AvailableFriends restaurant;
  final playerId;
  const RestaurantItem({Key? key,required this.restaurant,required this.playerId}) : super(key: key);




  @override
  State<RestaurantItem> createState() => _RestaurantItem();
}


class _RestaurantItem extends State<RestaurantItem> {

  String name = 'Follow';
  // RestaurantItem(this.restaurant, this.playerId);
  // SharedPreferences prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    // _addScrollListener();
    // getData();
  }

  Future<void> FollowUser() async {
    final uri = Uri.http('www.golfoneclub.com', '/api/users/follow', {
      'playerProfileId': widget.playerId,
      'friend': widget.restaurant.id,
    } .map((key, value) => MapEntry(key, value.toString())));
    print(uri);
    final response = await http.get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        name = 'Following';
      });
      // Padding.of(context).showSnackBar(SnackBar(
      //   content: Text("Post created successfully!"),
      // ));
    } else {
      // isSaving = false;
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text("Failed to create post!"),
      // ));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // restaurant.thumbnail != null && restaurant.thumbnail.isNotEmpty
            //     ? Ink(
            //   height: 100,
            //   width: 100,
            //   decoration: BoxDecoration(
            //     color: Colors.blueGrey,
            //     image: DecorationImage(
            //       fit: BoxFit.cover,
            //       image: NetworkImage(restaurant.thumbnail),
            //     ),
            //   ),
            // )
            //     : Container(
            //   height: 100,
            //   width: 100,
            //   color: Colors.blueGrey,
            //   child: Icon(
            //     Icons.restaurant,
            //     size: 30,
            //     color: Colors.white,
            //   ),
            // ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurant.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.location_on,
                    //       color: Colors.redAccent,
                    //       size: 15,
                    //     ),
                    //     SizedBox(width: 5),
                    //     Text(restaurant.locality),
                    //   ],
                    // ),
                    // SizedBox(height: 5),
                    // RatingBarIndicator(
                    //   rating: double.parse(restaurant.rating),
                    //   itemBuilder: (_, __) {
                    //     return Icon(
                    //       Icons.star,
                    //       color: Colors.amber,
                    //     );
                    //   },
                    //   itemSize: 20,
                    // ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    OutlinedButton(
                        onPressed: () => FollowUser(),
                        child: Text(name)),
                    // SizedBox(height: 7),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.location_on,
                    //       color: Colors.redAccent,
                    //       size: 15,
                    //     ),
                    //     SizedBox(width: 5),
                    //     Text(restaurant.locality),
                    //   ],
                    // ),
                    // SizedBox(height: 5),
                    // RatingBarIndicator(
                    //   rating: double.parse(restaurant.rating),
                    //   itemBuilder: (_, __) {
                    //     return Icon(
                    //       Icons.star,
                    //       color: Colors.amber,
                    //     );
                    //   },
                    //   itemSize: 20,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Restaurant {
  final String id;
  final String name;
  final String address;
  final String locality;
  final String rating;
  final int reviews;
  final String thumbnail;

  Restaurant._({
    required this.id,
    required this.name,
    required this.address,
    required this.locality,
    required this.rating,
    required this.reviews,
    required this.thumbnail,
  });
  factory Restaurant(Map json) => Restaurant._(
      id: json['restaurant']['id'],
      name: json['restaurant']['name'],
      address: json['restaurant']['location']['address'],
      locality: json['restaurant']['location']['locality'],
      rating: json['restaurant']['user_rating']['aggregate_rating']?.toString() ?? '',
      reviews: json['restaurant']['all_reviews_count'],
      thumbnail:
      json['restaurant']['featured_image'] ?? json['restaurant']['thumb']);
}