import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  DatabaseService databaseService = serviceLocator<DatabaseService>();

  User user1 = new User(sid:'6md78escFayIbJgMarfu');
  User user2 = new User(sid:'90lGrhbSjO0ghDwqxF92');

  Room room = new Room();
  room.id = 'W7MZYwu2NgPOrvE2WiVa';

  await test('DB methods', () {
    databaseService.getRoom(user1, user2)
        .then((value){
            expect(value.id, room.id);
            databaseService.getUserByName('test11')
                .then((value){
              expect(value, List);
            });
        });
  });
}