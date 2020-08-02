import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/services/authentication/authentication_service_default.dart';
import 'package:chatapp/services/authentication/authentication_service_google.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:flutter/cupertino.dart';

class ChatRoomsScreenViewModel extends ChangeNotifier {

  DatabaseService databaseService = serviceLocator<DatabaseService>();
  OptionStorageService localStorageService = serviceLocator<OptionStorageService>();
  AuthenticationServiceDefault authenticationServiceDefault = serviceLocator<AuthenticationServiceDefault>();
  AuthenticationServiceGoogle authenticationServiceGoogle = serviceLocator<AuthenticationServiceGoogle>();

  Stream streamRooms;
  Stream streamUsers;
  List<String> usersIds = [];

//  User user;
  String title;

  Map <String, dynamic> users = {};

  void loadData() async {

    await databaseService.getContacts(Local.user)
        .then((value){
          streamRooms = value;
          notifyListeners();
        });

//    Future.wait([initUser()])
//    .then((List responses){
//        Future.wait([initContacts()]);
//    });
//    await localStorageService.read('user')
//        .then((value){
//          if(value != null){
//            user = User.fromJson(value);
//            Constants.myName = user.name;
//            Constants.user = user;
//            title = user.name;
//          }
//          print(Constants.myName);
//        })
//        .then((_) async {
//          await databaseService.getContacts(Constants.user)
//              .then((value){
//                streamRooms = value;
////                print(value);
////                getUsers();
//                notifyListeners();
//              });
//
//        });

  }
//
//  Future<void> initUser() async {
//    await localStorageService.read('user')
//    .then((value){
//      if(value != null){
//        user = User.fromJson(value);
//        Constants.myName = user.name;
//        Constants.user = user;
//      }
//    });
//  }
//
//  Future<void> initContacts() async {
//    await databaseService.getContacts(Constants.user)
//    .then((value){
//      streamRooms = value;
//    });
//  }
//
//  Future<void> getUsers() async {
////    streamRooms.listen((data) async {
////      data.documents.forEach((doc){
////        users = doc["users"];
////        users.keys.forEach((element) {
////          if(element != Constants.user.sid){
////            usersIds.add(element);
////          }
////
////        });
////      });
////
////    });
//    print('!!!!!!!!!!!!!!!!!');
////    print(streamRooms.);
//    print('!!!!!!!!!!!!!!!!!');
//
//    if(usersIds.length > 0)
//    {
//      await databaseService.getUsers(usersIds)
//          .then((value){
//              streamUsers = value;
//              print(usersIds.length);
//              title = 'ttttttest';
//              notifyListeners();
//          });
//    }else{
//      print("array empty = =========");
//    }
//  }

  void signOut(){
    authenticationServiceDefault.signOut();
    authenticationServiceGoogle.signOut();
  }
}