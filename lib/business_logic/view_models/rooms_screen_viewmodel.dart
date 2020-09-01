import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/services/authentication/authentication_service_default.dart';
import 'package:chatapp/services/authentication/authentication_service_google.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/file_storage_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:flutter/cupertino.dart';

class RoomsScreenViewModel extends ChangeNotifier {

  DatabaseService databaseService = serviceLocator<DatabaseService>();
  OptionStorageService localStorageService = serviceLocator<OptionStorageService>();
  AuthenticationServiceDefault authenticationServiceDefault = serviceLocator<AuthenticationServiceDefault>();
  AuthenticationServiceGoogle authenticationServiceGoogle = serviceLocator<AuthenticationServiceGoogle>();
  FileStorageService storage = serviceLocator<FileStorageService>();

  Stream streamRooms;
  Stream streamUsers;

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

    if(Local.user.photoUrl == null)
    {
      await storage.loadImage('user/self_image/${Local.user.sid}')
      .then((value){
        Local.user.photoUrl = value;
        notifyListeners();
      })
      .catchError((error, stackTrace) {
        print("outer: $error");
      });
    }

    notifyListeners();
  }

  //TODO: get url
  Future<dynamic> getImage(String fileName) async {
    return  await storage.loadNetworkImage('user/self_image/${Local.user.sid}');
  }

  void signOut(){
    authenticationServiceDefault.signOut();
    authenticationServiceGoogle.signOut();
    notifyListeners();
  }
}