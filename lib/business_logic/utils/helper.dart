import 'dart:io';

import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/settings.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:elastic_client/console_http_transport.dart';
import 'package:elastic_client/elastic_client.dart' as elastic;
import 'package:uuid/uuid.dart';

import 'local.dart';

class Helper {
  OptionStorageService optionStorageService = serviceLocator<OptionStorageService>();

  void printModelsState() async {
    await optionStorageService.read('user').then((value){

      User user = User.fromMap(value);
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
    optionStorageService.save('user', User().toMap());
  }

  Map<String, dynamic> getIntelocutor(Room room){
//    return (room.from["sid"] == Local.user.sid) ? room.to :  room.from;
    return Map();
  }

  Future<bool> isInternetExist() async {
    try {
      return await InternetAddress.lookup('google.com')
      .then((value){
        return (value.isNotEmpty && value[0].rawAddress.isNotEmpty) ? true : false;
      });
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> log(String index, Map<String, dynamic> data) async {
    var uuid = Uuid();

    final transport = ConsoleHttpTransport(
        Uri.parse(Settings().e),
        basicAuth: BasicAuth(Settings().eU, Settings().eP)
    );
    final client = elastic.Client(transport);

    await client.updateDoc('flutter_index', 'my_type', uuid.v1().toString(), data);

    await transport.close();

  }

}