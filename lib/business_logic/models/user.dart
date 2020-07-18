import 'package:flutter/foundation.dart';

import 'base.dart';

class User extends ChangeNotifier implements BaseModel {
  String userId;
  String accountType;
  String name;
  String email;
  bool isLogged;
  String token;
  String _documentId;
  bool isExist = false;
  String age;
  String location;

  User({this.userId, this.name, this.email});

  void setId(String documentId){
    _documentId = documentId;
    notifyListeners();
  }

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'],
        location = json['location'],
        userId = json['id'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'location': location,
    'userId': userId
  };
}