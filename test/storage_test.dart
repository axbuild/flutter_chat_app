import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:async';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  OptionStorageService  optionStorageService = serviceLocator<OptionStorageService>();

  //User user = User();
  test('Storage read user object', () async {

    await  .read('user').then((value){
      print(value);
      //expect(value.runtimeType.toString(), 'User');

    });

  });
}