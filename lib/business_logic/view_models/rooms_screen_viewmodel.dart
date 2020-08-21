import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/services/authentication/authentication_service_default.dart';
import 'package:chatapp/services/authentication/authentication_service_google.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:flutter/cupertino.dart';

class RoomsScreenViewModel extends ChangeNotifier {

  DatabaseService databaseService = serviceLocator<DatabaseService>();
  OptionStorageService localStorageService = serviceLocator<OptionStorageService>();
  AuthenticationServiceDefault authenticationServiceDefault = serviceLocator<AuthenticationServiceDefault>();
  AuthenticationServiceGoogle authenticationServiceGoogle = serviceLocator<AuthenticationServiceGoogle>();

  Stream streamRooms;
  Stream streamUsers;
//  List<String> usersIds = [];

//  User user;
  String title;

  Map <String, dynamic> users = {};

  void loadData() async {
    Future.delayed(Duration(seconds: 1)).then((value) async {
      await databaseService.getRooms(Local.user)
          .then((value){
        streamRooms = value;
        notifyListeners();
      });
    });

  }

  void signOut(){
    authenticationServiceDefault.signOut();
    authenticationServiceGoogle.signOut();
  }
}