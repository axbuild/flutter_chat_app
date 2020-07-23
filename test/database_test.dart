import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  DatabaseService databaseService = serviceLocator<DatabaseService>();

  test('DB methods', () async {
    User user1 = new User(sid:'6md78escFayIbJgMarfu');
    User user2 = new User(sid:'90lGrhbSjO0ghDwqxF92');

    Room room = await databaseService.getRoom(user1, user2);
    print("=====================${room.id}");
    expect(room.id, 'W7MZYwu2NgPOrvE2WiVa');

  });
}