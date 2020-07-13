import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/storage_service.dart';
import 'package:chatapp/ui/screens/conversation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreenViewModel extends ChangeNotifier {

  StorageService storageService = serviceLocator<StorageService>();

//  QuerySnapshot searchSnapshot;
  List<User> _users = [];
  List<User> get users => _users;

  initiateSearch(text){
    _users.clear();

    storageService
        .getUserByUserName(text)
        .then((val){
          _users.addAll(val);
          notifyListeners();
        });
    notifyListeners();
   }

  createChatRoomAndStartConversation({BuildContext context, String userName}){

    if(userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users" : users,
        "chatroomid" : chatRoomId
      };
      storageService.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(
              chatRoomId
          )
      ));
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