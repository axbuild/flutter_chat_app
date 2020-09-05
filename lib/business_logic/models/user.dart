import 'package:flutter/foundation.dart';

import 'base.dart';

class User implements BaseModel {
  String sid;
  String lid;
  String pid;
  String login;
  String name;
  String lastName;
  String email;
  String phoneNumber;
  String photoUrl;
  String token;
  String age;
  String location;
  String description;


  bool hasKnowledge = false;
  bool isLogged;
  bool isFree = false;

  User({
    this.sid,
    this.lid,
    this.pid,
    this.login,
    this.name,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.isLogged,
    this.description,
    this.hasKnowledge,
    this.isFree
  });

  User.empty()
      : isLogged = false,
        hasKnowledge = false;

  User.fromMap(Map<String, dynamic> json)
      : sid   = json['sid'],
        lid   = json['lid'],
        pid   = json['pid'],
        login = json['login'],
        name  = json['name'],
        lastName = json['last_name'],
        email = json['email'],
        isLogged = json['is_logged'],
        description = json['description'],
        hasKnowledge = json['has_knowledge'],
        isFree = json['is_free'];

  Map<String, dynamic> toMap() => {
    'sid': sid,
    'lid': lid,
    'pid': pid,
    'login': login,
    'name': name,
    'last_name': lastName,
    'email': email,
    'is_logged': isLogged,
    'description': description,
    'has_knowledge': hasKnowledge,
    'is_free': isFree
  };

}