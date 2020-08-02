import 'package:chatapp/business_logic/models/message.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:flutter/cupertino.dart';

class ConversationScreenViewModel extends ChangeNotifier {
  DatabaseService storageService;
  Stream chatMessagesStream;

  User _user;
  Room room;

  void loadData(User user){
      _user = user;
      storageService = serviceLocator<DatabaseService>();

      storageService.getRoom(Local.user, _user)
      .then((value){
        room = value;
        storageService.getConversationMessages(value.id)
            .then((value){
          chatMessagesStream = value;
          notifyListeners();
        });

      });


      notifyListeners();
  }

  sendMessage(text){
      storageService.addConversationMessages(room, Message(
        author: Local.user.sid,
        text: text,
        time: DateTime.now().millisecondsSinceEpoch
      ));
      notifyListeners();
  }

}