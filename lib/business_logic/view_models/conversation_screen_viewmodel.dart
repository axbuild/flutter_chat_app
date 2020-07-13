import 'package:chatapp/business_logic/utils/constants.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/storage_service.dart';
import 'package:flutter/cupertino.dart';

class ConversationScreenViewModel extends ChangeNotifier {
  StorageService storageService;
  Stream chatMessagesStream;
  String _chatRoomId;

  void loadData(String chatRoomId){
      _chatRoomId = chatRoomId;
      storageService = serviceLocator<StorageService>();
      storageService.getConversationMessages(chatRoomId).then((value){
        chatMessagesStream = value;
        notifyListeners();
      });
      notifyListeners();
  }

  sendMessage(text){
      Map<String,dynamic> messageMap = {
        "message": text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      storageService.addConversationMessages(_chatRoomId, messageMap);
      notifyListeners();
  }

}