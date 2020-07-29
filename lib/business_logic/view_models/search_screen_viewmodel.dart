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
    _users.clear();

    databaseService
        .getUserByName(text)
        .then((val){
          _users.addAll(val);
          notifyListeners();
        });
    notifyListeners();
  }

  createChatRoomAndStartConversation({BuildContext context, User user}){

    if(user.name != Constants.myName) {

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
          .then((currentRoom){
            room = currentRoom;
            if(room.id == null){
              databaseService.addRoom(chatRoomMap)
                .then((newRoom){
                  room = newRoom;
              });
            }
          })
          .then((_){
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
      print("you cannot send message to yourself");
    }
    notifyListeners();
  }

  void loadData(){
    room = new Room();
    notifyListeners();
  }
}