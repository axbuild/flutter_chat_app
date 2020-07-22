import 'package:chatapp/business_logic/models/message.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';

abstract class DatabaseService {

  Future<User> getUserByEmail(String userEmail);

  Future<List<User>> getUserByName(String userName);

  Future<bool> uploadUserInfo(userMap);

  Future<Room> createChatRoom(String chatRoomId, chatRoomMap);

  Future<Message> addConversationMessages(String chatRoomId, messageMap);

  Future<Stream> getConversationMessages(String chatRoomId);

  Future<Stream> getChatRooms(String userName);
}