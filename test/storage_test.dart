import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  test('Storage Access', () async {
    StorageService storageService = serviceLocator<StorageService>();
    final User user = await storageService.getUserByUserEmail('test@test.te');

    expect(user, isNotNull);
  });
}