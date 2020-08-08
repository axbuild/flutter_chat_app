import 'package:flutter/cupertino.dart';
import 'base.dart';

class Room extends ChangeNotifier implements BaseModel {
  String sid;
  Map<String, dynamic> users;
  Map<String, dynamic> from;
  Map<String, dynamic> to;
  int time;

  Room({
    this.sid,
    this.users,
    this.from,
    this.to,
    this.time
  });

  Room.fromMap(Map<String, dynamic> json)
      :sid = json['sid'],
       users = json['users'],
       from = json['from'],
       to = json['to'],
       time = json['time'];

  Map<String, dynamic> toMap()  => {
    'sid': sid,
    'users': users,
    'from': from,
    'to': to,
    'time': time
  };
}