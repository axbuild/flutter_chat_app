import 'package:flutter/foundation.dart';

class User  extends ChangeNotifier {
  String userId;
  String accountType;
  String name;
  String email;
  String token;
  String _documentId;
  bool isExist = false;

  User({this.userId});

  void setId(String documentId){
    _documentId = documentId;
    notifyListeners();
  }
}