import 'dart:ui';
import 'package:chatapp/business_logic/view_models/signin_screen_viewmodel.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  SignInScreenModelView model  = serviceLocator<SignInScreenModelView>();

  @override
  void initState() {
    model.loadData();
    super.initState();
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
                  key: model.formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                              .hasMatch(val) ? null : 'Please Provide a valid email';
                        },
                        controller: model.emailTextEditingController,
                        style: mediumInputFieldStyle(),
                        decoration: textFieldInputDecoration('email'),
                        textAlign: TextAlign.center,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          return val.length > 6 ? null: 'Please Provide password 6+ character';
                        },
                        controller: model.passwordTextEditingController,
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
                    model.signIn(context);
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
                      model.signInWithGoogle();
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