
import 'dart:html';

class User{
  dynamic playerProfileId;
  String name;
  EmailInputElement email;
  String unit;
  String color;
  User({this.playerProfileId, required this.name, required this.email, required this.unit, required this.color});
}