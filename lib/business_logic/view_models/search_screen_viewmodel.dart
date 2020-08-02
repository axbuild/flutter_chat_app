import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/ui/screens/conversation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreenViewModel extends ChangeNotifier {

  DatabaseService databaseService = serviceLocator<DatabaseService>();

  List<User> _users = [];
  List<User> get users => _users;
  Room room;

  initiateSearch(text){
    print(text);
    databaseService.getUsersByEmail(text, Local.user.email)
        .then((val) => showOccurrences(val));
  }

  void showOccurrences(List<User> users){
    _users.clear();
    _users.addAll(users);
    notifyListeners();
  }

  createChatRoomAndStartConversation({BuildContext context, User user}){

    if(user.sid != null &&  Local.user.sid != null) {

      Map<String, dynamic> chatRoomMap = {
        "users": {
          user.sid: true,
          Local.user.sid: true
        },
        "from": Local.user.sid,
        "to": user.sid,
        "time": new DateTime.now().millisecondsSinceEpoch
      };

      databaseService.getRoom(user, Local.user)
          .then((currentRoom) {
            room = currentRoom;
          })
          .then((value){
            if(room.id == null){
              databaseService.addRoom(chatRoomMap)
              .then((newRoom){
                room = newRoom;
                databaseService.setContact(Local.user, user);
                databaseService.setContact(user, Local.user);
              })
              .then((_){
                if(room.id == null)  print('Cant create new room');
                navigateToConversationScreen(user, context);
              });
            }else{
              print('Room not found, will be created');
            }
          })
          .then((value){
              if(room.id == null)  print('Cant create new room');
              navigateToConversationScreen(user, context);
          });

    }else{
      print("Fields required! user1: ${user.sid} user2:${Local.user.sid}");
    }
    notifyListeners();
  }

  void navigateToConversationScreen(User user, context){
       Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(
              user
//                      room.id//chatRoomId
          )
      ));
  }

  void loadData(){
    room = new Room();
    notifyListeners();
  }
}