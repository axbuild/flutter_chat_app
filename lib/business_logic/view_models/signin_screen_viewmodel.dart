
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
import 'package:chatapp/services/authentication/authentication_service_default.dart';
import 'package:chatapp/services/authentication/authentication_service_google.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:chatapp/ui/screens/chat_rooms_screen.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreenModelView extends ChangeNotifier {

  DatabaseService  databaseService = serviceLocator<DatabaseService>();
  OptionStorageService  optionStorageService = serviceLocator<OptionStorageService>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthenticationServiceDefault authenticationServiceDefault = serviceLocator<AuthenticationServiceDefault>();
  AuthenticationServiceGoogle authenticationServiceGoogle = serviceLocator<AuthenticationServiceGoogle>();

  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  User user;

  void signIn(BuildContext context) async {
    isLoading = true;

    if(formKey.currentState.validate()){

      databaseService.getUserByEmail(emailTextEditingController.text.trim())
          .then((value) => user = value);

      authenticationServiceDefault.email = emailTextEditingController.text.trim();
      authenticationServiceDefault.password = passwordTextEditingController.text.trim();

      authenticationServiceDefault.signIn()
        .then((value) => finishAuthorize(context, value));

    }
  }

  void signInWithGoogle(BuildContext context){
    isLoading = true;

    authenticationServiceGoogle.signIn()
    .then((value) => finishAuthorize(context, value));

  }

  void finishAuthorize(BuildContext context, dynamic value){
    if(value != null){
      user.isLogged = true;
      optionStorageService.save('user', user.toJson());

      Constants.user = user;

      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ChatRoom()
      ));
      notifyListeners();
    } else {
      showPopUpDialog(context, 'User not found!');
    }
  }

  void loadData() async {
    notifyListeners();
  }

}