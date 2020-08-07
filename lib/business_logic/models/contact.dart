import 'package:flutter/cupertino.dart';
import 'base.dart';

class Contact extends ChangeNotifier implements BaseModel {
  String id;

  Contact({this.id});

  Contact.fromMap(Map<String, dynamic> json)
      :id = json['id'];

  Map<String, dynamic> toMap()  => {
    'id': id
  };
}