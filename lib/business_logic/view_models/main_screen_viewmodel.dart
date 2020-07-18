import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/push_notifications.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:flutter/cupertino.dart';

class MainScreenViewModel extends ChangeNotifier {

  OptionStorageService optionStorageService;

  bool userIsLoggedIn = false;
  String title = 'Flutter Chat App';

  void loadData() async {
    //TODO: init USER if not exist in local storage, create new
    optionStorageService.read('user').then((user){
      print("getLoggedInState:value: ${user.isLogged}");
      userIsLoggedIn = user.isLogged ?? false;
    });

    PushNotificationsManager().init();

    notifyListeners();
  }
}