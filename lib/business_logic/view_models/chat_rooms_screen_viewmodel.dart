import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
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
  List usersIds = [];

  User user;

  void loadData() async {
    localStorageService.read('user')
        .then((value){
          if(value != null){
            user = User.fromJson(value);
            Constants.myName = user.name;
            Constants.user = user;
          }
        })
        .then((_){
          databaseService.getRooms(Constants.user)
              .then((value){
                streamRooms = value;
//                value.toList().then( (value) => print("******") );
              });
        });


    notifyListeners();
  }

  void signOut(){
    authenticationServiceDefault.signOut();
    authenticationServiceGoogle.signOut();
  }
}