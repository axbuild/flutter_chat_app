import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
import 'package:chatapp/business_logic/utils/helperfunctions.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/storage_service.dart';
import 'package:chatapp/ui/screens/conversation_screen.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

String _myName;

class _State extends State<SearchScreen> {

  StorageService storageService = serviceLocator<StorageService>();
//  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;
  List<User> users = [];

  Widget searchList(){
    print('________');
    print(users);
    return Container();
    return users.length != null ? ListView.builder(
        itemCount: users.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return SearchTile(
            userName: users[index].name,
            userEmail: users[index].email,
          );
        }) : Container();
  }

  initiateSearch(){
    storageService
      .getUserByUserName(searchTextEditingController.text)
        .then((val){
          setState(() {
            print(val);
//            searchSnapshot = val;
            //users.addAll(val);
          });
    });
  }

  //create chatroom, send user to conversation screen, pushreplacement
  createChatRoomAndStartConversation({String userName}){

    if(userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);
//      print("CUSTOM: onTap create ChatRoom ${chatRoomId}");
//      print("CUSTOM: onTap create ChatRoom ${Constants.myName}");
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

  }

  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 1),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(userName, style: mediumTextStyle()),
              Text(userEmail, style: mediumTextStyle()),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(
                  userName: userName
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Message"),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      decoration: textFieldInputDecoration('search'),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Icon(
                        Icons.search,
                        color: Colors.black38,
                        size: 28.0
                    ),
                  ),

                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}