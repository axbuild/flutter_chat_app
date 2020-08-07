import 'package:flutter/foundation.dart';

import 'base.dart';

class User implements BaseModel {
  String sid;
  String lid;
  String pid;
  String login;
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
    this.login,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.isLogged
  });

  User.empty(): isLogged = false;

  User.fromMap(Map<String, dynamic> json)
      : sid   = json['sid'],
        lid   = json['lid'],
        pid   = json['pid'],
        login = json['login'],
        name  = json['name'],
        email = json['email'],
        isLogged = json['isLogged'];

  Map<String, dynamic> toMap() => {
    'sid': sid,
    'lid': lid,
    'pid': pid,
    'login': login,
    'name': name,
    'email': email,
    'isLogged': isLogged
  };

}