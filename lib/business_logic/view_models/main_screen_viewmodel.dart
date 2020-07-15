import 'package:chatapp/business_logic/utils/options.dart';
import 'package:chatapp/business_logic/utils/push_notifications.dart';
import 'package:flutter/cupertino.dart';

class MainScreenViewModel extends ChangeNotifier {

  bool userIsLoggedIn = false;
  String title = 'Flutter Chat App';

  void loadData() async {
    await Options.getUserLogged().then((value){
      print("getLoggedInState:value: ${value}");
      userIsLoggedIn = value ?? false;
    });

    PushNotificationsManager().init();

    notifyListeners();
  }
}