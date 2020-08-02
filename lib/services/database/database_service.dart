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



  Future<Room> addRoom(chatRoomMap);

  Future<Room> getRoom(User user1, User user2);

  Future<Stream> getRooms(User user);


  Future<Message> addConversationMessages(Room room, Message message);

  Future<Stream> getConversationMessages(String chatRoomId);

}