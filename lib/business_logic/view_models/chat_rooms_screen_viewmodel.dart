import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
import 'file:///C:/Users/29228796/AndroidStudioProjects/flutter_chat_app/lib/services/predicated/auth.dart';
import 'package:chatapp/services/authentication/authentication_service_default.dart';
import 'package:chatapp/services/authentication/authentication_service_google.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:flutter/cupertino.dart';

class ChatRoomsScreenViewModel extends ChangeNotifier {

  DatabaseService databaseService;
  OptionStorageService localStorageService;
//  AuthMethods authMethods;
  AuthenticationServiceDefault authenticationServiceDefault = serviceLocator<AuthenticationServiceDefault>();
  AuthenticationServiceGoogle authenticationServiceGoogle = serviceLocator<AuthenticationServiceGoogle>();

  Stream chatRoomsStream;

  void loadData() async {
//    authMethods = new AuthMethods();
    databaseService = serviceLocator<DatabaseService>();
    localStorageService = serviceLocator<OptionStorageService>();


    localStorageService.read('user').then((user){
      Constants.myName = user.name;
    });


    databaseService.getChatRooms(Constants.myName).then((value){
      chatRoomsStream = value;
    });
    notifyListeners();
  }

  void signOut(){
    authenticationServiceDefault.signOut();
    authenticationServiceGoogle.signOut();
  }
}