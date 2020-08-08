import 'package:chatapp/business_logic/models/message.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseService {

  Future<User> getUserByEmail(String userEmail);

  Future<List<User>> getUserByName(String userName);

  Future<bool> uploadUserInfo(userMap);

  Future<Stream> getUsers(List sids);

  Future<List<User>> getUsersByEmail(String userEmail, String excludeEmail);


  Future<String> addContact(User user, User contact);

  Future<void> setContact(User user, User contact);

  Future<Stream> getContacts(User user);



//  Future<Room> addRoom(Room room, Function getRoomId);

  Future<Room> addRoom(Room room);

  Future<Room> getRoom(User fromUser, User toUser);

  Future<Stream> getRooms(User user);


  Future<Message> addConversationMessages(Room room, Message message);

  Future<Stream> getConversationMessages(String chatRoomId);

}