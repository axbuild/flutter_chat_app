import 'package:flutter/cupertino.dart';
import 'base.dart';

class Room extends ChangeNotifier implements BaseModel {
  String id;

  Room({this.id});

  Room.fromMap(Map<String, dynamic> json)
      :id = json['id'];

  Map<String, dynamic> toMap()  => {
    'id': id
  };
}