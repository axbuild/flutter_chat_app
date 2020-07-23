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
      //String chatRoomId = getChatRoomId(userName, Constants.myName);

      print("++++++++++++++++++");
      print(user.sid);
      print('_________');
      print(Constants.user.sid);
      print("++++++++++++++++++");
      Room room = new Room();
      databaseService.getRoom(user, Constants.user).then((value){
        room = value;
      });
//      List<String> users = [userName, Constants.myName];
//      Map<String, dynamic> chatRoomMap = {
//        userName : users,
//        "chatroomid" : chatRoomId
//      };
      Map<String, dynamic> chatRoomMap = {
        "users": {
          user.sid: true,
          Constants.user.sid: true
        },
        "time": new DateTime.now().millisecondsSinceEpoch
      };

      databaseService.createChatRoom(room, chatRoomMap).then((value){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ConversationScreen(
                value.id//chatRoomId
            )
        ));
      });

    }else{
      print("you cannot send message to yourself");
    }
    notifyListeners();
  }

  getChatRoomId(String a, String b) {
    if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    }else{
      return "$a\_$b";
    }
  }


  void loadData(){
    notifyListeners();
  }
}