import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
import 'package:chatapp/business_logic/utils/helperfunctions.dart';
import 'package:chatapp/business_logic/view_models/search_screen_viewmodel.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/storage_service.dart';
import 'package:chatapp/ui/screens/conversation_screen.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

String _myName;

class _State extends State<SearchScreen> {

  SearchScreenViewModel model  = serviceLocator<SearchScreenViewModel>();

  @override
  void initState() {
    model.loadData();
    super.initState();
  }


  Widget searchList(){
    return model.users.length != null ? ListView.builder(
        itemCount: model.users.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return SearchTile(
            userName: model.users[index].name,
            userEmail: model.users[index].email,
          );
        }) : Container();
  }

  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 1),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(userName, style: mediumTextStyle()),
              Text(userEmail, style: mediumTextStyle()),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              model.createChatRoomAndStartConversation(
                  context: context,
                  userName: userName
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Message"),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: model.searchTextEditingController,
                      decoration: textFieldInputDecoration('search'),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      model.initiateSearch();
                    },
                    child: Icon(
                        Icons.search,
                        color: Colors.black38,
                        size: 28.0
                    ),
                  ),

                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}
