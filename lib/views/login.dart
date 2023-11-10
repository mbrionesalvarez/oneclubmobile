import 'package:flutter/material.dart';
import 'package:oneclubmobile/network/network_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';

  String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#174038"),
        title: Text('Login',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/static/images/IMG_3321-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextFormField(
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
              decoration: InputDecoration(hintText: 'email', hintStyle: TextStyle(color: Colors.white),),
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
            TextFormField(
              obscureText: true,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
              decoration: InputDecoration(hintText: 'password', hintStyle: TextStyle(color: Colors.white)),
              onChanged: (value) {
                setState(() {
                  pass = value;
                });
              },
            ),
            InkWell(
              onTap: () async {
                if (username == '') {
                  EasyLoading.showError('Missing email');
                } else if (pass == '') {
                  EasyLoading.showError('Missing password');
                } else {
                  await HttpService.login(username, pass, context);
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: HexColor("#174038"),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ],
        ),
      ),

    );
  }
}