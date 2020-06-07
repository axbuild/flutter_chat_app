import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: Icon(
        Icons.adjust,
        color: Colors.white,
        size: 24.0
    )
  );
}

//    title: Image.asset("assets/images/logo.png", height:50),

InputDecoration textFieldInputDecoration(String hintText){
  return  InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          color: Colors.white
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      )
  );
}

TextStyle simpleTextFieldStyle(){
  return TextStyle(
    color: Colors.white
  );
}