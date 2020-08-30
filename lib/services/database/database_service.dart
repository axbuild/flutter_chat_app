import 'package:chatapp/business_logic/models/call.dart';
import 'package:chatapp/business_logic/models/event.dart';
import 'package:chatapp/business_logic/models/message.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseService {

  Future<User> getUserByEmail(String userEmail);

  Future<List<User>> getUserByName(String userName);

  Future<bool> uploadUserInfo(userMap);

  Future<bool> setUser(User user);

  Future<Stream> getUsers(List sids);

  Future<List<User>> getUsersByEmail(String userEmail, String excludeEmail);

  Future<List<User>> getUsersByKnowledge(String needle);


  Future<String> addContact(User user, User contact);

  Future<void> setContact(User user, User contact);

  Future<Stream> getContacts(User user);



//  Future<Room> addRoom(Room room, Function getRoomId);

  Future<Room> addRoom(Room room);

  Future<void> setRoom(Room room);

  Future<Room> getRoom(User fromUser, User toUser);

  Future<Stream> getRooms(User user);


  Future<void> setEvent(Room room, User recipient, Event event);


  Future<Message> addConversationMessages(Room room, Message message);

  Future<Stream> getConversationMessages(String chatRoomId);

  Future<Call> addCall(Room room, Call call);

  Future<Stream> getCall(Room room, Call call);

}