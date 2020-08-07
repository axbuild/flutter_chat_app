import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/business_logic/utils/push_notifications.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:flutter/cupertino.dart';

class MainScreenViewModel extends ChangeNotifier {

  OptionStorageService  optionStorageService = serviceLocator<OptionStorageService>();

//TODO: init auth provider to check user by method currentUser
//  getCurrentUser().then((value){
//  print("=====================");
//  print(value.email);
//  print("=====================");
//  });
//
  User user = User.empty();
  String title = 'Flutter Chat App';

  void loadData() async {
    await optionStorageService.read('user')
        .then((value){
          if(value != null){
            user = User.fromMap(value);
          } else {
            optionStorageService.save('user', user.toMap());
          }
          Local.user = user;
          notifyListeners();
        });

    PushNotificationsManager().init();
    notifyListeners();
  }
}