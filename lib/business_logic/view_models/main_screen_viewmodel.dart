import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/push_notifications.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:flutter/cupertino.dart';

class MainScreenViewModel extends ChangeNotifier {

  OptionStorageService  optionStorageService = serviceLocator<OptionStorageService>();

  User user = User();
  bool userIsLoggedIn = false;
  String title = 'Flutter Chat App';

  void loadData() async {

    await optionStorageService.read('user').then((value){
      print(":::::::::::::::::Main > getLoggedInState:value: ${value.isLogged}");
      userIsLoggedIn = value.isLogged ?? false;
      notifyListeners();
    });

    PushNotificationsManager().init();

    notifyListeners();
  }
}