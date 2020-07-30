import 'package:flutter/cupertino.dart';
import 'base.dart';

class Contact extends ChangeNotifier implements BaseModel {
  String id;

  Contact({this.id});

  Contact.fromJson(Map<String, dynamic> json)
      :id = json['id'];

  Map<String, dynamic> toJson()  => {
    'id': id
  };
}