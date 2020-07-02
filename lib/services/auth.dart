import 'package:chatapp/modal/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
 final FirebaseAuth _auth = FirebaseAuth.instance;
 final GoogleSignIn _googleSignIn = GoogleSignIn();

 User _userFromFirebaseUser(FirebaseUser user) {
   return user != null ? User(userId: user.uid) : null;
 }

 Future signInWithEmailAndPassword(String email, String password) async {
   try{
     AuthResult result = await _auth.signInWithEmailAndPassword
       (email: email, password: password);
     FirebaseUser firebaseUser = result.user;
     return _userFromFirebaseUser(firebaseUser);

   }catch(e){
    print(e.toString());
   }
 }

 Future signUpwithEmailAndPassword(String email, String password) async {
   try {
     AuthResult result = await _auth.createUserWithEmailAndPassword
       (email: email, password: password);
     FirebaseUser firebaseUser = result.user;
     return _userFromFirebaseUser(firebaseUser);
   } catch(e) {
     print(e.toString());
   }
 }

 Future resetPass(String email) async {
   try{
     return await _auth.sendPasswordResetEmail(email: email);
   }catch(e){
     print(e.toString());
   }
 }

 Future signOut() async {
   try{
     return await _auth.signOut();
   }catch(e){
     print(e.toString());
   }
 }

 Future googleSignIn() async {
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

 Future googleSignOut() async {
   try {
     return await _auth.signOut().then((val) {
       _googleSignIn.signOut();
     });
   }catch(e){
     print(e.toString());
   }
 }

}