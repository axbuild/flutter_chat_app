import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:flutter/cupertino.dart';

class ChatRoomsScreenViewModel extends ChangeNotifier {

  DatabaseService databaseService;
  OptionStorageService localStorageService;
  AuthMethods authMethods;
  Stream chatRoomsStream;

  void loadData() async {
    authMethods = new AuthMethods();
    databaseService = serviceLocator<DatabaseService>();
    localStorageService = serviceLocator<OptionStorageService>();

    //TODO: Done!
    localStorageService.read('user').then((user){
      Constants.myName = user.name;
    });


    databaseService.getChatRooms(Constants.myName).then((value){
      chatRoomsStream = value;
    });
    notifyListeners();
  }
}