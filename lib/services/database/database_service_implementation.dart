import 'dart:convert';

import 'package:chatapp/business_logic/models/message.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServiceImpl implements DatabaseService{

  static CollectionReference _roomsRef = Firestore.instance.collection("rooms");
  static CollectionReference _usersRef = Firestore.instance.collection("users");
  static CollectionReference _contactsRef = Firestore.instance.collection("contacts");

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
  Future<String> addContact(User user, User contact) async {
    Map<String, dynamic> contactMap = {
      'id': contact.sid,
      'name': contact.name
    };
    return await _usersRef
        .document(user.sid)
        .collection("contacts")
        .add(contactMap)
        .then((ref) => ref.documentID);
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

  Future<Stream> getContacts(User user) async {

    return await _usersRef
        .document(user.sid)
        .collection("contacts")
        .snapshots();

    List documentIds = [];
    Stream users;

    return Future.wait([getRoomsDocIds(user)])
      .then((List responses) {
//        print(responses.first);
//        print(responses.first);
//        documentIds = responses.first;
        return _usersRef
//          .where('name', whereIn: responses )
//          .where(FieldPath.documentId, whereIn: documentIds )
          .where(FieldPath.documentId, whereIn: [1,2,3] )
          .snapshots();
        return null;
      });

//      return await _roomsRef
//        .where("users."+user.sid, isEqualTo: true)
//        .getDocuments()
//        .then((snapshot){
//            print("===${snapshot.documents.length}");
//            snapshot.documents.forEach((element){
//              documentIds.add(element.documentID);
//            });
//        })
//        .then((_) async {
//           print("=***==${documentIds.length}");
//           return await _usersRef
//                  .where('uid', whereIn: documentIds )
//                  .snapshots();
//        });
  }

  Future<List> getRoomsDocIds(User user) async {
    List documentIds = [];
    Map <String, bool> users = {};
    return documentIds;
    return await _roomsRef
        .where("users."+user.sid, isEqualTo: true)
        .getDocuments()
        .then((snapshot){
          print("===${snapshot.documents.length}");
          snapshot.documents.forEach((element){
//            print(element.data['users']);
//            users = json.decode(element.data['users'].toString());
            users.forEach((key, value) {
              if(key != user.sid){
                documentIds.add(key);
              }
            });

          });
          return documentIds;
        });
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
  Future<List<User>> getUsersByEmail(String userEmail, String excludeEmail) async {
    List<User> users = [];

    return await _usersRef
        .where("email", isGreaterThanOrEqualTo: userEmail )
        .getDocuments()
        .then((snapshot){
          snapshot.documents.forEach((element) {
            if(excludeEmail != element.data['email'])
              users.add(User(
                  sid: element.documentID,
                  name: element.data['name'],
                  email: element.data['email']
              ));
          });
          print(users.length);
          return users;
    });
  }


}