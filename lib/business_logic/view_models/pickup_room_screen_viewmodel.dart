
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:flutter/cupertino.dart';

class PickupRoomScreenViewModel extends ChangeNotifier {

  DatabaseService databaseService = serviceLocator<DatabaseService>();

}