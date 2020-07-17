import 'package:flutter/cupertino.dart';

import 'base.dart';

class Message extends ChangeNotifier implements BaseModel  {
  String id;

  Message();

  Message.fromJson(Map<String, dynamic> json)
      :id = json['id'];

  Map<String, dynamic> toJson()  => {
    'id': id
  };
}