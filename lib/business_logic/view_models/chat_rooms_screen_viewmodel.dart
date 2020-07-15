import 'package:chatapp/business_logic/utils/constants.dart';
import 'package:chatapp/business_logic/utils/options.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/storage_service.dart';
import 'package:flutter/cupertino.dart';

class ChatRoomsScreenViewModel extends ChangeNotifier {

  StorageService storageService;
  AuthMethods authMethods;
  Stream chatRoomsStream;

  void loadData() async {
    authMethods = new AuthMethods();
    storageService = serviceLocator<StorageService>();
    Constants.myName = await Options.getUserName();

    storageService.getChatRooms(Constants.myName).then((value){
      chatRoomsStream = value;
    });
    notifyListeners();
  }
}