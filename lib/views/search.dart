import 'package:chatapp/services/database.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch(){
    databaseMethods
      .getUserByUsername(searchTextEditingController.text)
        .then((val){
          setState(() {
            searchSnapshot = val;
          });
    });
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.documents.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
        return SearchTile(
          userName:searchSnapshot.documents[index].data["name"],
          userEmail: searchSnapshot.documents[index].data["email"],
        );
      }) : Container();
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
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
                      controller: searchTextEditingController,
                      decoration: textFieldInputDecoration('search'),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
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

class SearchTile extends StatelessWidget {

  final String userName;
  final String userEmail;
  SearchTile({this.userName, this.userEmail});

  @override
  Widget build(BuildContext context) {
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
          Container(
            decoration: BoxDecoration(
              color: Colors.black38,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text("Message"),
          )
        ],
      ),
    );
  }
}
