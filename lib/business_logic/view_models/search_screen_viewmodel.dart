import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chatapp/business_logic/models/event.dart';
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
    databaseService.getUsersByKnowledge(text)
        .then((val) => showOccurrences(val));
  }

  void showOccurrences(List<User> users){
    _users.clear();
    _users.addAll(users);
    notifyListeners();
  }

  startConversation({BuildContext context, User user, String type}){
    print('local user' + Local.user.sid + ' Remote user ' + user.sid);
    if(user.sid != null &&  Local.user.sid != null) {

      databaseService.getRoom(Local.user, user)
          .then((currentRoom) {
            room = currentRoom;
          })
          .then((value){
            if(room.sid == null){
              databaseService.addRoom(Room(
                  users: {
                    user.sid.toString(): user.toMap(),
                    Local.user.sid.toString(): Local.user.toMap(),
                  },
                  createdBy: Local.user.sid,
                  time: new DateTime.now().millisecondsSinceEpoch
              ))
              .then((newRoom){
                room = newRoom;
//                databaseService.setContact(Local.user, user);
//                databaseService.setContact(user, Local.user);
              })
              .then((_){
                if(room.sid == null)  print('Cant create new room');
                if(type == 'chat') navigateToConversationScreen(context, user);
                if(type == 'video') startVideoConversation(context, room);
              });
            }else{
              print('Room not found, will be created');
            }
          })
          .then((value){
              if(room.sid == null)  print('Cant create new room');
              navigateToConversationScreen(context, user);
              if(type == 'video'){
                //databaseService.setEvent(room, user, Event(isIncomingVideoCall: true));
                startVideoConversation(context, room);
              }
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
            channelName: room.sid,
            room: room,
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