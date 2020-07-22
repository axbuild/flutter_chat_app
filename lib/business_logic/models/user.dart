import 'package:flutter/foundation.dart';

import 'base.dart';

class User extends ChangeNotifier implements BaseModel {
  String sid;
  String lid;
  String pid;
  String name;
  String email;
  String phoneNumber;
  String photoUrl;
  String token;
  String age;
  String location;

  bool isLogged;

  User({
    this.sid,
    this.lid,
    this.pid,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.isLogged
  });

  User.empty(): isLogged = false;

  User.fromJson(Map<String, dynamic> json)
      : sid = json['sid'],
        lid = json['lid'],
        pid = json['pid'],
        name = json['name'],
        email = json['email'],
        isLogged = json['isLogged'];

  Map<String, dynamic> toJson() => {
    'sid': sid,
    'lid': lid,
    'pid': pid,
    'name': name,
    'email': email,
    'isLogged': isLogged
  };

}