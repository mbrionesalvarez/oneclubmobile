import 'package:flutter/material.dart';
import 'package:oneclubmobile/views/login.dart';
import 'package:oneclubmobile/views/register.dart';
import 'package:hexcolor/hexcolor.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/static/images/IMG_3321-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                  child: Text(
                    'Login',
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: HexColor("#174038"),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                  child: Text(
                    'Register',
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: HexColor("#009B77"),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
          ),
        ],
      ),
    ),
    );
  }
}