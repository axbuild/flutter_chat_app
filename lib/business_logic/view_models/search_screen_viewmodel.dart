import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/ui/screens/chat_room_screen.dart';
import 'package:chatapp/ui/screens/call_room_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SearchScreenViewModel extends ChangeNotifier {

  DatabaseService databaseService = serviceLocator<DatabaseService>();

  ClientRole _role = ClientRole.Broadcaster;

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

  startConversation({BuildContext context, User user, String type}){

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
                if(type == 'chat') navigateToConversationScreen(context, user);
                if(type == 'video') startVideoConversation(context, room);
              });
            }else{
              print('Room not found, will be created');
            }
          })
          .then((value){
              if(room.id == null)  print('Cant create new room');
              navigateToConversationScreen(context, user);
              if(type == 'video') startVideoConversation(context, room);
          });

    }else{
      print("Fields required! user1: ${user.sid} user2:${Local.user.sid}");
    }
    notifyListeners();
  }

//  startVoiceConversation({BuildContext context, User user}){}

  void startVideoConversation(BuildContext context, Room room) async {

      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallRoom(
            channelName: room.id,
            role: _role,
          ),
        ),
      );

  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }

  void navigateToConversationScreen(context, User user){
       Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatRoomScreen(
              user
          )
      ));
  }

  void loadData(){
    room = new Room();
    notifyListeners();
  }
}