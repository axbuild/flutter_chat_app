import 'package:flutter/cupertino.dart';

import 'base.dart';

class Message extends ChangeNotifier implements BaseModel  {
  String id;
  String author;
  String text;
  int time;

  Message({
    this.id,
    this.author,
    this.time,
    this.text
  });

  Message.fromJson(Map<String, dynamic> json)
      :id = json['id'],
       author = json['author'],
       time = json['time'],
       text = json['text'];

  Map<String, dynamic> toJson()  => {
    'id': id,
    'author': author,
    'time': time,
    'text': text
  };
}