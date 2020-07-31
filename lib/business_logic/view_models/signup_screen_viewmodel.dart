import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
import 'package:chatapp/services/authentication/authentication_service_default.dart';
import 'package:chatapp/services/authentication/authentication_service_google.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:chatapp/ui/screens/chat_rooms_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreenViewModel extends ChangeNotifier {

  AuthenticationServiceDefault authenticationServiceDefault = serviceLocator<AuthenticationServiceDefault>();
  AuthenticationServiceGoogle authenticationServiceGoogle = serviceLocator<AuthenticationServiceGoogle>();
  DatabaseService databaseService = serviceLocator<DatabaseService>();
  OptionStorageService optionStorageService = serviceLocator<OptionStorageService>();

  User user;
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  Map<String, String> userInfoMap = {};

  bool signUp(BuildContext context){
    user = User.empty();
    if(!formKey.currentState.validate()) return false;

      isLoading = true;

//      userInfoMap = {
//        "name" : userNameTextEditingController.text,
//        "email" : emailTextEditingController.text,
//        "token" : Constants.token
//      };

      user.name = userNameTextEditingController.text.trim();
      user.email = emailTextEditingController.text.trim();
      optionStorageService.save('user', user.toJson());

      authenticationServiceDefault.email = emailTextEditingController.text.trim();
      authenticationServiceDefault.password = passwordTextEditingController.text.trim();
      authenticationServiceDefault.signUp()
          .then((val) => finishAuthorize(context, val));

      return true;
  }

  void googleSignUp(BuildContext context){
    authenticationServiceGoogle.signUp()
        .then((val) => finishAuthorize(context, val));
  }

  void finishAuthorize(BuildContext context, dynamic value){
    databaseService.uploadUserInfo(value.toJson());

    value.isLogged = true;
    optionStorageService.save('user', value.toJson());
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => ChatRoom()
    ));
  }

  void loadData(){
    notifyListeners();
  }
}