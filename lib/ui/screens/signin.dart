import 'dart:ui';
import 'package:chatapp/business_logic/utils/helperfunctions.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat_rooms_screen.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods dateBaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn(){
    if(formKey.currentState.validate()){
      HelperFunctions.saveUserEmailInSharedPreference(emailTextEditingController.text);

      dateBaseMethods.getUserByUserEmail(emailTextEditingController.text)
          .then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameInSharedPreference(snapshotUserInfo.documents[0].data['name']);
        //HelperFunctions.saveUserEmailInSharedPreference(snapshotUserInfo.documents[0].data['name']);
      });

      setState((){
        isLoading = true;
      });

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
    setState((){
      isLoading = true;
    });

    authMethods.googleSignIn()
    .then((val){
      print("=======================");
      print(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.center,
          child:Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                              .hasMatch(val) ? null : 'Please Provide a valid email';
                        },
                        controller: emailTextEditingController,
                        style: mediumInputFieldStyle(),
                        decoration: textFieldInputDecoration('email'),
                        textAlign: TextAlign.center,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          return val.length > 6 ? null: 'Please Provide password 6+ character';
                        },
                        controller: passwordTextEditingController,
                        style: mediumInputFieldStyle(),
                        decoration: textFieldInputDecoration('password'),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height:8,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text("ForgotPassword", style: simpleTextStyle(),),
                  ),
                ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Color(0xff39796b),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("Sign In",
                      style: mediumBtnStyle(),
                    ),
                  ),
                ),
                SizedBox(height:8,),
                GestureDetector(
                  onTap: () {
                      signInWithGoogle();
                      print('Sign in with Google');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("Sign In with Google",
                      style: mediumBtnStyle(),
                    ),
                  ),
                ),
                SizedBox(height:8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account? ", style: mediumTextStyle(),),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Register now", style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 17,
                            decoration: TextDecoration.underline
                        ),),
                      ),
                    )
                  ],
                ),
                SizedBox(height:8,),
              ],
            ),
          ),
        ),
      )
    );
  }
}
