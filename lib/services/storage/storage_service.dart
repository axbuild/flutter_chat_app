import 'package:chatapp/business_logic/models/user.dart';

abstract class StorageService {
  Future<User> getUserByUserName(String userName);

  Future<User> getUserByUserEmail(String userEmail);
}