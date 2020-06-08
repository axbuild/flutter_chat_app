import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: <Widget>[
            TextField(
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration('email'),
            ),
            TextField(
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration('password'),
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
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff007EF4),
                    const Color(0xff2A75BC)
                  ]
                )
              ),
              child: Text("Sign In", style: TextStyle(
                    color: Colors.white,
                    fontSize:18
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
