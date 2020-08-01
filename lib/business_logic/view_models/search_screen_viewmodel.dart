import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
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
    databaseService
        .getUsersByEmail(text, Constants.user.email)
        .then((val) => showOccurrences(val));
  }

  void showOccurrences(List<User> users){
    _users.clear();
    _users.addAll(users);
    notifyListeners();
  }

  createChatRoomAndStartConversation({BuildContext context, User user}){

    if(user.sid != null &&  Constants.user.sid != null) {

      Map<String, dynamic> chatRoomMap = {
        "users": {
          user.sid: true,
          Constants.user.sid: true
        },
        "author": Constants.user.sid,
        "recipient": user.sid,
        "time": new DateTime.now().millisecondsSinceEpoch
      };

      databaseService.getRoom(user, Constants.user)
          .then((currentRoom) {
            room = currentRoom;
          })
          .then((value){
            if(room.id == null){
              databaseService.addRoom(chatRoomMap)
              .then((newRoom){
                room = newRoom;
                databaseService.addContact(Constants.user, user);
                databaseService.addContact(user, Constants.user);
              });
            }
          })
          .then((value){
            if(room.id != null){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ConversationScreen(
                      room.id//chatRoomId
                  )
              ));
            }else{
              print('Cant create new room');
            }
          });

    }else{
      print("user1: ${user.sid} user2:${Constants.user.sid}");
      print("you cannot send message to yourself");
    }
    notifyListeners();
  }

  void loadData(){
    room = new Room();
    notifyListeners();
  }
}