import 'dart:convert';

import 'package:chatapp/business_logic/models/call.dart';
import 'package:chatapp/business_logic/models/event.dart';
import 'package:chatapp/business_logic/models/message.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServiceImpl implements DatabaseService{

  static CollectionReference _roomsRef = Firestore.instance.collection("rooms");
  static CollectionReference _usersRef = Firestore.instance.collection("users");
  static CollectionReference _callsRef = Firestore.instance.collection("calls");

  @override
  Future<Message> addConversationMessages(Room room, Message message) {
    _roomsRef
        .document(room.sid)
        .collection("chats")
        .add(message.toMap()).catchError((e){
      print(e.toString());
    });
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
  Future<Call> addCall(Room room, Call call) async {
    _roomsRef
        .document(room.sid)
        .collection("calls")
        .add(call.toMap())
        .catchError((e){
          print(e.toString());
        });
  }

  @override
  Future<Stream> getCall(Room room, Call call) async {
    return await _callsRef
        .document(room.sid)
        .collection("calls")
        .orderBy("time", descending: false)
        .snapshots();
  }

//  @override
//  Future<Room> addRoom(Room room, Function getRoomId) async {
//    return await _roomsRef
//        .document(getRoomId())
//        .setData(room.toMap())
//        .then((value) => room.sid = getRoomId());
//  }

  @override
  Future<Room> addRoom(room) async {
    return await _roomsRef
        .add(room.toMap())
        .then((ref) => new Room(sid: ref.documentID));
  }

  @override
  Future<void> setRoom(room) async {
    return await _roomsRef
        .document(room.sid)
        .setData(room.toMap());
  }

  Future<Room> getRoom(User fromUser, User toUser) async  {
    return await _roomsRef
        .where("users."+fromUser.sid+".sid", isEqualTo: fromUser.sid)
        .where("users."+toUser.sid+".sid", isEqualTo: toUser.sid)
        .limit(1)
        .getDocuments()
        .then((snapshot) => new Room(sid: snapshot.documents.first.documentID))
        .catchError((e) => new Room());
  }

  @override
  Future<Stream> getRooms(User user) async {
    return await _roomsRef
        .where("users."+user.sid+".sid", isEqualTo: user.sid)
        .snapshots();
  }

  @override
  Future<void> setEvent(Room room, User recipient, Event event) async {
    await _roomsRef
        .document(room.sid)
        .updateData({
      'event_'+recipient.sid: event.toMap()
    });
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
  Future<void> setContact(User user, User contact) async {
    Map<String, dynamic> contactMap = {
      'id': contact.sid,
      'name': contact.name
    };
    await _usersRef
        .document(user.sid)
        .collection("contacts")
        .document(contact.sid)
        .setData(contactMap);
  }

  Future<Stream> getContacts(User user) async {

    return await _usersRef
        .document(user.sid)
        .collection("contacts")
        .snapshots();
  }

  @override
  Future<bool> uploadUserInfo(userMap) {
    _usersRef
        .add(userMap).catchError((e){
      print(e.toString());
    });
  }

  @override
  Future<bool> setUser(User user) async {
    await _usersRef
        .document(user.sid)
        .setData(user.toMap());
  }

  @override
  Future<User> getUser(User user) async {
    return await _usersRef
        .document(user.sid)
        .get()
        .then((snapshot) => User(
        sid : user.sid,
        name : snapshot['name'],
        email : snapshot['email'],
        isLogged : true));
  }

  Future<Stream> getUsers(List documentIds) async {
    return await _usersRef
        .where('uid', whereIn: documentIds )
        .snapshots();
  }

  Future<List> getRoomsDocIds(User user) async {
    List documentIds = [];
    Map <String, bool> users = {};
    return documentIds;
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

  @override
  Future<List<User>> getUsersByKnowledge(String needle) async {
    List<User> users = [];

    return await _usersRef
        .where("knowledge."+needle.toLowerCase(), isGreaterThan: 0 )
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