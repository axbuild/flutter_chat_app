import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/business_logic/utils/push_notifications.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/file_storage_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:flutter/cupertino.dart';

class MainScreenViewModel extends ChangeNotifier {

  OptionStorageService  optionStorageService = serviceLocator<OptionStorageService>();
  FileStorageService storage = serviceLocator<FileStorageService>();

  void loadData() async {
    Local.user = User.empty();
    await optionStorageService.read('user')
    .then((value){
      if(value != null){
        Local.user = User.fromMap(value);
      }
      optionStorageService.save('user', Local.user.toMap());
      notifyListeners();
    });
    PushNotificationsManager().init();
  }

}
