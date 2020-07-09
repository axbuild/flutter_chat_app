import 'package:chatapp/business_logic/view_models/signup_screen_viewmodel.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SignUp> {

  SignUpScreenViewModel model = serviceLocator<SignUpScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body:  model.isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator()
        )
      ) :
        SingleChildScrollView(
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
                      children: [
                        TextFormField(
                          validator: (val){
                            return val.isEmpty || val.length < 4 ? "Please Provide UserName!" : null;
                          },
                          controller: model.userNameTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration('username'),
                        ),
                        TextFormField(
                          validator: (val){
                            return RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                .hasMatch(val) ? null : 'Please Provide a valid email';
                          },
                          controller: model.emailTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration('email'),
                        ),
                        TextFormField(
                          obscureText: true,
                          validator: (val){
                            return val.length > 6 ? null: 'Please Provide password 6+ character';
                          },
                          controller: model.passwordTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration('password'),
                        )
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
                    onTap:(){
                        model.signMeUp(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xffadcbed),
                              const Color(0xffadcbed)
                            ]
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text("Sign Up",
                        style: mediumTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(height:8,),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("Sign In with Google", style: TextStyle(
                        color: Colors.black38,
                        fontSize:18
                    ),
                    ),
                  ),
                  SizedBox(height:8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have account? ", style: mediumTextStyle(),),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding:EdgeInsets.symmetric(vertical: 8),
                          child: Text("Sign In now", style: TextStyle(
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

