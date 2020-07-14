import 'package:chatapp/business_logic/models/user.dart';

abstract class AuthService {
  Future<User> signIn();
  Future<User> signUp();
  Future<bool> signOut();
}