import 'package:flutter/cupertino.dart';
import 'base.dart';

class Room implements BaseModel {
  String sid;
  Map<String, dynamic> users;
  Map<String, dynamic> from;
  Map<String, dynamic> to;
  int time;
  Map<String, dynamic> events;


  Room({
    this.sid,
    this.users,
    this.from,
    this.to,
    this.time,
    this.events
  });

  Room.fromMap(Map<String, dynamic> json)
      :sid = json['sid'],
       users = json['users'],
       from = json['from'],
       to = json['to'],
       time = json['time'],
       events = json['events'];

  Map<String, dynamic> toMap()  => {
    'sid': sid,
    'users': users,
    'from': from,
    'to': to,
    'time': time,
    'event': events
  };
}