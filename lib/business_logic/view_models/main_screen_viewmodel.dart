import 'package:chatapp/business_logic/utils/helperfunctions.dart';
import 'package:chatapp/business_logic/utils/push_notifications.dart';
import 'package:flutter/cupertino.dart';

class MainScreenViewModel extends ChangeNotifier {

  bool userIsLoggedIn = false;
  String title = 'Flutter Chat App';

  void loadData() async {
    await HelperFunctions.getUserLoggedSharedPreference().then((value){
      print("getLoggedInState:value: ${value}");
      userIsLoggedIn = value ?? false;
    });

    PushNotificationsManager().init();

    notifyListeners();
  }
}