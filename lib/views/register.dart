import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oneclubmobile/network/network_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String username = '';

  String email = '';

  String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#009B77"),
          title: Text('Register',
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
              Container(
                color: HexColor("#174038"),
              child: Text('Please register with your Garmin Connect credentials.',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
              Container(

          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextField(
              //   decoration: InputDecoration(hintText: 'username'),
              //   onChanged: (value) {
              //     setState(() {
              //       username = value;
              //     });
              //   },
              // ),
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
                    await HttpService.register(username, pass, context);
                  }

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
        )])));
  }
}


class WelcomeRegisterScreen extends StatefulWidget {
  @override
  _WelcomeRegisterScreen createState() => _WelcomeRegisterScreen();
}

class _WelcomeRegisterScreen extends State<WelcomeRegisterScreen> {
  String username = '';

  String email = '';

  String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#009B77"),
          title: Text('Register',
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
                mainAxisAlignment: MainAxisAlignment.start,
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

                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Column(children: [
                          Container(color: HexColor("#174038"),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              child:Text('Important Instructions',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 23, fontFamily: 'Arial'))),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Before you import your Garmin Data, there is a set of best practices to ensure a full experience of the OneClub platform:',
                              style: TextStyle(color: HexColor("#174038"), fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Arial')),
                          SizedBox(
                            height: 10,
                          ),
                          Text('1. Go to your Garmin Golf app, open one scorecard and verify that shots are registered by looking hole by hole.',
                              style: TextStyle(color: HexColor("#174038"), fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Arial')),
                          SizedBox(
                            height: 10,
                          ),
                          Text("2. If you don't see any shots registered, you will need to update your Garmin device to start tracking your game. Download Garmin Express App and update your device.",
                              style: TextStyle(color: HexColor("#174038"), fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Arial')),
                          SizedBox(
                            height: 10,
                          ),
                          Text('3. Importing all your historical data will take some time depending on the number of rounds you have already registered. Once the process starts please wait to load all your registered rounds',
                              style: TextStyle(color: HexColor("#174038"), fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Arial'))
                        ]),
                        
                      ],
                    ),
                  )])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              // MaterialPageRoute(builder: (context) => DashboardScreen())
              MaterialPageRoute(builder: (context) => ImportDataUser())
          );
        },
        backgroundColor: HexColor("#009B77"),
      tooltip: 'Next',
      child: const Icon(Icons.arrow_forward),
    ),
    );
  }
}


class ImportDataUser extends StatefulWidget {
  @override
  _ImportDataUser createState() => _ImportDataUser();
}

class _ImportDataUser extends State<ImportDataUser> {
  String username = '';

  String email = '';
  bool _isSelected = false;
  String pass = '';
  String unit = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#009B77"),
        title: Text('Register',
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container(
                //   color: HexColor("#174038"),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [Column(
                //       children: [Text('ONE',
                //         style: TextStyle(color: HexColor('#FCE300'), fontWeight: FontWeight.w700, fontSize: 50, fontFamily: 'Arial'),)],
                //     ), Column(
                //       children: [Text('CLUB',
                //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 50, fontFamily: 'Arial'),),],
                //     )],),
                //   padding: EdgeInsets.only(left: 40, right: 20, top: 20, bottom: 20),
                // ),
                // SizedBox(
                //   height: 20,
                // ),

                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Column(children: [
                        Container(color: HexColor("#174038"),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child:Text('Import your scorecards',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'Arial'))),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Select Unit of Measurement',
                            style: TextStyle(color: HexColor("#174038"), fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Arial')),
                        SizedBox(
                          height: 10,
                        ),
                        ToggleSwitch(
                          minWidth: 90.0,
                          cornerRadius: 20.0,
                          activeBgColors: [[HexColor("#174038")!], [HexColor("#174038")!]],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: 1,
                          totalSwitches: 2,
                          labels: ['Yards', 'Meters'],
                          radiusStyle: true,
                          onToggle: (index) {
                            if (index == 0) {
                              unit = 'yards';
                            } else {
                              unit = 'meters';
                            }
                            // print('switched to: $index');
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        LabeledCheckbox(
                          label: 'I acknowledge that OneClub will be downloading my data on my behalf. OneClub will NEVER download your data unless you manually refresh the OneClub platform',
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          value: _isSelected,
                          onChanged: (bool newValue) {
                            setState(() {
                              _isSelected = newValue;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_isSelected) {
                              await HttpService.import_data(unit, context);
                            } else {
                              EasyLoading.showError('Need to accept terms and conditions');
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Center(
                                child: Text(
                                  'Import Data',
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
                                )),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: HexColor("#009B77"),
                                borderRadius: BorderRadius.all(Radius.circular(25))),
                          ),
                        ),
                      ]),

                    ],
                  ),
                )])),
    );
  }
}




class DropdownMenuUnit extends StatefulWidget {
  const DropdownMenuUnit({super.key});

  @override
  State<DropdownMenuUnit> createState() => _DropdownMenuUnit();
}

class _DropdownMenuUnit extends State<DropdownMenuUnit> {
  List<String> list = <String>['meters', 'yards'];
  String dropdownValue = 'yards';

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
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

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
