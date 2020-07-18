
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:chatapp/ui/screens/chat_rooms_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreenModelView extends ChangeNotifier {

  DatabaseService  databaseService = serviceLocator<DatabaseService>();
  OptionStorageService  optionStorageService = serviceLocator<OptionStorageService>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();

  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  User user;

  void signIn(BuildContext context) async {
    if(formKey.currentState.validate()){
//      user = new User();
//      Options.saveUserEmail(emailTextEditingController.text);
      databaseService.getUserByUserEmail(emailTextEditingController.text)
          .then((value){
            optionStorageService.save('user', value.toJson()).then((res){
              user = value;
            print('user save on signin');
        });
      });
//      Options.saveUserName(user.name);
//      user.email = emailTextEditingController.text;

      isLoading = true;

      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text)
          .then((val){
        if(val != null){
          user.isLogged = true;
          optionStorageService.save('user', user.toJson());

//          Options.saveUserLogged(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }
      });
    }
  }

  void signInWithGoogle(){
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

/*
  dateBaseMethods.getUserByUserEmail(emailTextEditingController.text)
      .then((val){
    snapshotUserInfo = val;
    HelperFunctions.saveUserNameInSharedPreference(snapshotUserInfo.documents[0].data['name']);
 });*/

}