import 'package:chatapp/business_logic/models/user.dart';

abstract class AuthenticationService {
  Future<User> signIn();
  Future<User> signUp();
  Future<bool> signOut();
  Future<User> getCurrentUser();
}