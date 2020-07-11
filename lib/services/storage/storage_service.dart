import 'package:chatapp/business_logic/models/message.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';

abstract class StorageService {

  Future<User> getUserByUserEmail(String userEmail);

  Future<List<User>> getUserByUserName(String userName);

  Future<bool> uploadUserInfo(userMap);

  Future<Room> createChatRoom(String chatRoomId, chatRoomMap);

  Future<Message> addConversationMessages(String chatRoomId, messageMap);

  Future<Stream> getConversationMessages(String chatRoomId);
//  Future<List<Message>> getConversationMessages(String chatRoomId);

  Future<Stream> getChatRooms(String userName);
//  Future<List<Room>> getChatRooms(String userName);
}