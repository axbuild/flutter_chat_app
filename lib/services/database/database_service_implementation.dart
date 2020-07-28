import 'package:chatapp/business_logic/models/message.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServiceImpl implements DatabaseService{

  static CollectionReference _roomsRef = Firestore.instance.collection("rooms");
  static CollectionReference _usersRef = Firestore.instance.collection("users");

  @override
  Future<Message> addConversationMessages(String chatRoomId, messageMap) {
    _roomsRef
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e){
      print(e.toString());
    });
  }

  @override
  Future<Room> addRoom(chatRoomMap) async {
    return await _roomsRef
        .add(chatRoomMap)
        .then((ref) => new Room(id: ref.documentID));
  }

  Future<Room> getRoom(User user1, User user2) async  {
     return await _roomsRef
        .where("users."+user1.sid, isEqualTo: true)
        .where("users."+user2.sid, isEqualTo: true)
        .limit(1)
        .getDocuments()
        .then((snapshot) => new Room(id: snapshot.documents.first.documentID))
        .catchError((e) => new Room());
  }

  @override
  Future<Stream> getRooms(User user) async {
    return await _roomsRef
        .where("users."+user.sid, isEqualTo: true)
//        .where("users", arrayContains: userName)
        .snapshots();
  }

  @override
  Future<Stream> getConversationMessages(String chatRoomId) async {

   return await _roomsRef
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  @override
  Future<User> getUserByEmail(String userEmail) async {

    return await _usersRef
        .where("email", isEqualTo: userEmail )
        .getDocuments()
        .then((snapshot) => new User(
            sid : snapshot.documents.first.documentID,
            name : snapshot.documents.first.data['name'],
            email : snapshot.documents.first.data['email'],
            isLogged : true
        ));
  }

  @override
  Future<bool> uploadUserInfo(userMap) {
    _usersRef
        .add(userMap).catchError((e){
      print(e.toString());
    });
  }

  Future<Stream> getUsers(List documentIds) async {
    return await _usersRef
        .where('uid', whereIn: documentIds )
        .snapshots();
  }

  @override
  Future<List<User>> getUserByName(String userName) async {
    List<User> users = [];

    return await _usersRef
        .where("name", isEqualTo: userName )
        .getDocuments()
        .then((snapshot){
          snapshot.documents.forEach((element) {
            users.add(User(
                sid: element.documentID,
                name: element.data['name'],
                email: element.data['email']
            ));
          });
          return users;
        });
  }
  
}