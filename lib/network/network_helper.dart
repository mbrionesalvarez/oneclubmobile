import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:oneclubmobile/views/landing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oneclubmobile/views/new_navbar.dart';
import 'package:oneclubmobile/views/register.dart';



class NetworkHelper {
  Future<http.Response> get(String endpoint) async {
    var url = Uri.parse(endpoint);
    var response = await http.get(url);
    return response;
  }
}

// class NetWorkHelperParams {
//   Future<http.Response> get(String endpoint, Map params) async {
//     final uri = Uri.http('www.golfoneclub.com', endpoint, params);
//     http.Response response = await http.get(uri);
//     return response;
//   }
// }

class HttpService {
  static final _client = http.Client();


  static var _loginUrl = Uri.parse('https://golfoneclub.com/api/user/login');

  static var _registerUrl = Uri.parse('http://localhost:5000/register');

  static login(username, pass, context) async {
    debugPrint(username);
    debugPrint(pass);
    // var url = Uri.parse('https://golfoneclub.com/api/user/login');
    // var response = await http.post(url);
    var user = username;
    var pwd = pass;
    final uri = Uri.http('www.golfoneclub.com', '/api/user/login', {
      'email': user,
      'pwd': pwd,
    });
    http.Response response = await http.get(uri);
    debugPrint(response.body);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (json['error'] != 'Invalid username or password') {
        await EasyLoading.showSuccess('Login Sucessfully');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        SharedPreferences.setMockInitialValues({});
        await prefs.setString("name", json['name']);
        await prefs.setString("email", json['email']);
        await prefs.setString("unit", json['unit']);
        await prefs.setString("color", json['color']);
        await prefs.setInt("playerProfileId", json['playerProfileId']);
        await EasyLoading.show(status: 'Loading Data...');
        final uri = Uri.http('www.golfoneclub.com', '/api/user/refresh', {
          'email': user,
          'pwd': pwd,
        });
        print(uri);
        http.Response response = await http.get(uri);
        print(response.body);
        EasyLoading.dismiss();
        if (response.statusCode == 200) {
          Navigator.pushReplacement(context,
              // MaterialPageRoute(builder: (context) => DashboardScreen())
              MaterialPageRoute(builder: (context) => MyAppFinal())
          );
        }
      } else {
        EasyLoading.showError(json['error']);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  static register(email, pass, context) async {
    var user = email;
    var pwd = pass;
    // Navigator.pushReplacement(context,
    //     // MaterialPageRoute(builder: (context) => DashboardScreen())
    //     MaterialPageRoute(builder: (context) => WelcomeRegisterScreen()));
    await EasyLoading.show(status: 'Loading Data...');
    final uri = Uri.http('www.golfoneclub.com', '/api/user/register', {
      'email': user,
      'pwd': pwd,
    });
    http.Response response = await http.get(uri);
    EasyLoading.dismiss();
    debugPrint(response.body);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (json['error'] != 'Invalid username or password') {
        await EasyLoading.showSuccess('User Registered');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        SharedPreferences.setMockInitialValues({});
        // await prefs.setString("name", json['name']);
        await prefs.setString("email", email);
        // await prefs.setString("unit", json['unit']);
        // await prefs.setString("color", json['color']);
        // await prefs.setInt("playerProfileId", json['playerProfileId']);
        await prefs.setString("pwd", pwd);
        Navigator.pushReplacement(context,
            // MaterialPageRoute(builder: (context) => DashboardScreen())
            MaterialPageRoute(builder: (context) => WelcomeRegisterScreen()));
      } else {
        await EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
      // http.Response response = await _client.post(_registerUrl, body: {
      //   // 'uname': username,
      //   'mail': email,
      //   'passw': pass,
      // });
      //
      // if (response.statusCode == 200) {
      //   var json = jsonDecode(response.body);
      //
      //   if (json['status'] == 'username already exist') {
      //     await EasyLoading.showError(json['status']);
      //   } else {
      //     await EasyLoading.showSuccess(json['status']);
      //     Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder: (context) => MyAppFinal()));
      //   }
      // } else {
      //   await EasyLoading.showError(
      //       "Error Code : ${response.statusCode.toString()}");
      // }
    }
  }
  static import_data(unit, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('email');
    var pwd = prefs.getString('pwd');
    await EasyLoading.show(status: 'Loading Data...');
    final uri = Uri.http('www.golfoneclub.com', '/api/user/import', {
      'email': user,
      'pwd': pwd,
      'unit': unit
    });
    http.Response response = await http.get(uri);
    debugPrint(response.body);

    if (response.statusCode == 200) {
      final uri = Uri.http('www.golfoneclub.com', '/api/user/login', {
        'email': user,
        'pwd': pwd,
      });
      http.Response response = await http.get(uri);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        var json = jsonDecode(response.body);

        if (json['error'] != 'Invalid username or password') {
          // await EasyLoading.showSuccess('Login Sucessfully');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          SharedPreferences.setMockInitialValues({});
          await prefs.setString("name", json['name']);
          await prefs.setString("email", json['email']);
          await prefs.setString("unit", json['unit']);
          await prefs.setString("color", json['color']);
          await prefs.setInt("playerProfileId", json['playerProfileId']);
          EasyLoading.dismiss();

          Navigator.pushReplacement(context,
                // MaterialPageRoute(builder: (context) => DashboardScreen())
                MaterialPageRoute(builder: (context) => MyAppFinal())
            );

        } else {
          EasyLoading.showError(json['error']);
        }
      } else {
        await EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

}
