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
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: HexColor("#174038"),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Column(
                children: [Text('ONE',
                  style: TextStyle(color: HexColor('#FCE300'), fontWeight: FontWeight.w700, fontSize: 50, fontFamily: 'Arial'),)],
              ), Column(
                children: [Text('CLUB',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 50, fontFamily: 'Arial'),),],
              )],),
            padding: EdgeInsets.only(left: 40, right: 20, top: 20, bottom: 20),
          ),
          SizedBox(
            height: 20,
          ),
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
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
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
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
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