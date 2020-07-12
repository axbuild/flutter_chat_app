import 'package:chatapp/business_logic/models/message.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/storage/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StorageServiceImpl implements StorageService{
  @override
  Future<Message> addConversationMessages(String chatRoomId, messageMap) {
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e){
      print(e.toString());
    });
  }

  @override
  Future<Room> createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId).setData(chatRoomMap)
        .catchError((e){
      print(e.toString());
    });
  }

  @override
  Future<Stream> getChatRooms(String userName) async {
    return await Firestore.instance.collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }

  @override
  Future<Stream> getConversationMessages(String chatRoomId) async {

   return await Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  @override
  Future<User> getUserByUserEmail(String userEmail) async {
    User user = User();
    await Firestore.instance.collection("users")
        .where("email", isEqualTo: userEmail )
        .getDocuments()
        .then((snapshot){
            user.name = snapshot.documents[0].data['name'];
        });
    return user;
  }

  @override
  Future<bool> uploadUserInfo(userMap) {
    Firestore.instance.collection("users")
        .add(userMap).catchError((e){
      print(e.toString());
    });
  }

  @override
  Future<List<User>> getUserByUserName(String userName) async {

    List<User> users = [];

    await Firestore.instance.collection("users")
        .where("name", isEqualTo: userName )
        .getDocuments()
        .then((snapshot){

        snapshot.documents.forEach((element) {
                users.add(User(
                  name: element.data['name'],
                  email: element.data['email']
                ));
        });
      });

    return users;
  }
  
}