import 'package:chatapp/business_logic/models/user.dart';

abstract class CallService {
  Future<User> start();
  Future<User> stop();
}