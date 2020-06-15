import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: Row(
      children: <Widget>[
        Icon(
            Icons.supervised_user_circle,
            color: Colors.white,
            size: 28.0
        ),
        Spacer(flex:2),
        Text(
          'Chat App'
        )
      ],
    ),
  );
}

//    title: Image.asset("assets/images/logo.png", height:50),
//    title: Image.asset("assets/images/logo.png", height:50),

InputDecoration textFieldInputDecoration(String hintText){
  return  InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          color: Colors.black38
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black38)
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black38)
      )
  );
}

TextStyle simpleTextStyle(){
  return TextStyle(
    color: Colors.black38,
    fontSize:18
  );
}

TextStyle mediumTextStyle(){
  return TextStyle(
      color: Colors.black38,
      fontSize:20
  );
}