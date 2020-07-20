import 'package:chatapp/business_logic/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'authentication_service.dart';

class AuthenticationServiceGoogle implements AuthenticationService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(
        pid: user.uid,
        name: user.displayName,
        email: user.email
    ) : null;
  }

  @override
  Future<User> signIn() async {
    try{
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider
          .getCredential(idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      AuthResult result = await _auth.signInWithCredential(credential);

      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){

      print(e.toString());
    }
  }

  @override
  Future<bool> signOut() async {
    try {
       await _auth.signOut().then((val) {
        _googleSignIn.signOut();
      });
       return true;
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Future<User> signUp() async {
    try{
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider
          .getCredential(idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      AuthResult result = await _auth.signInWithCredential(credential);

      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){

      print(e.toString());
    }
  }

}