import 'package:chatapp/business_logic/models/message.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';

abstract class DatabaseService {

  Future<User> getUserByEmail(String userEmail);

  Future<List<User>> getUserByName(String userName);

  Future<bool> uploadUserInfo(userMap);

  Future<Room> createChatRoom(Room room, chatRoomMap);

//  Future<Room> addRoom();

  Future<Room> getRoom(User user1, User user2);

  Future<Message> addConversationMessages(String chatRoomId, messageMap);

  Future<Stream> getConversationMessages(String chatRoomId);

  Future<Stream> getChatRooms(String userName);
}