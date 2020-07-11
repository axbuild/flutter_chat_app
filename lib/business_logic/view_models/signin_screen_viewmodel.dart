
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/helperfunctions.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/storage_service.dart';
import 'package:chatapp/ui/screens/chat_rooms_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreenModelView extends ChangeNotifier {

  StorageService  storageService = serviceLocator<StorageService>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
//  DatabaseMethods dateBaseMethods = new DatabaseMethods();

  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  void signIn(BuildContext context) async {
    if(formKey.currentState.validate()){
      HelperFunctions.saveUserEmailInSharedPreference(emailTextEditingController.text);

      User user = await storageService.getUserByUserEmail(emailTextEditingController.text);
      HelperFunctions.saveUserNameInSharedPreference(user.name);

      print("~~~~~~~~~${user.name}");
      /*
      dateBaseMethods.getUserByUserEmail(emailTextEditingController.text)
          .then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameInSharedPreference(snapshotUserInfo.documents[0].data['name']);
     });*/

      isLoading = true;

      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text)
          .then((val){
        if(val != null){
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }
      });
    }
  }

  signInWithGoogle(){
    isLoading = true;

    authMethods.googleSignIn()
        .then((val){
      print("=======================");
      print(val);
    });
  }

  void loadData() async {
    notifyListeners();
  }

}