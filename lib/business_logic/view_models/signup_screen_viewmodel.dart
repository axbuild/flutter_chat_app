import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/services/authentication/authentication_service_default.dart';
import 'package:chatapp/services/authentication/authentication_service_google.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:chatapp/ui/screens/chat_rooms_screen.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreenViewModel extends ChangeNotifier {

  AuthenticationServiceDefault authenticationServiceDefault = serviceLocator<AuthenticationServiceDefault>();
  AuthenticationServiceGoogle authenticationServiceGoogle = serviceLocator<AuthenticationServiceGoogle>();
  DatabaseService databaseService = serviceLocator<DatabaseService>();
  OptionStorageService optionStorageService = serviceLocator<OptionStorageService>();

//  User user;
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

//  Map<String, String> userInfoMap = {};

  bool signUp(BuildContext context){
//    user = User.empty();
    if(!formKey.currentState.validate()) return false;

      isLoading = true;

      authenticationServiceDefault.email = emailTextEditingController.text.trim();
      authenticationServiceDefault.password = passwordTextEditingController.text.trim();
      authenticationServiceDefault.signUp()
          .then((value) => finishAuthorize(context, value));

      return true;
  }

  void googleSignUp(BuildContext context){
    authenticationServiceGoogle.signUp()
        .then((value) => finishAuthorize(context, value));
  }

  void finishAuthorize(BuildContext context, User user){
    if(user != null) {
      user.name = userNameTextEditingController.text.trim();
      databaseService.uploadUserInfo(user.toMap());

      Local.user = user;

      user.isLogged = true;
      optionStorageService.save('user', user.toMap());
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ChatRoom()
      ));
    } else {
      showPopUpDialog(context, 'User already exist, smth wrong!');
    }
  }

  void loadData(){
    notifyListeners();
  }
}