import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';

class Helper {
  OptionStorageService optionStorageService = serviceLocator<OptionStorageService>();

  void printModelsState() async {
    await optionStorageService.read('user').then((value){

      User user = User.fromJson(value);
      if(user.runtimeType.toString() == 'User'){
        print(user.runtimeType.toString());
      }
      else {
        print('object not found');
      }

    });
  }

  void clearModelState() async {
    await optionStorageService.remove('user');
  }

  void saveUser() async {
    optionStorageService.save('user', User().toJson());
  }
}