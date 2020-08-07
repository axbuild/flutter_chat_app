import 'package:chatapp/business_logic/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_service.dart';

class AuthenticationServiceDefault implements AuthenticationService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(
        pid: user.uid,
        name: user.displayName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoUrl
    ) : null;
  }

  @override
  Future<User> signIn() async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword
        (email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);

    }catch(e){
      print(e.toString());
    }
  }

  @override
  Future<bool> signOut() async {
    try{
      await _auth.signOut();
      return true;
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Future<User> signUp() async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword
        (email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e) {
      print(e.toString());
    }
  }

  @override
  Future<User> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return _userFromFirebaseUser(currentUser);
  }
}