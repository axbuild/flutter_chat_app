import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/view_models/search_screen_viewmodel.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SearchScreen> {

  SearchScreenViewModel model  = serviceLocator<SearchScreenViewModel>();
  TextEditingController _searchTextEditingController;

  @override
  void initState() {
    model.loadData();
    _searchTextEditingController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchScreenViewModel>(
      create: (context) => model,
      child: Consumer<SearchScreenViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("this ${model.users.length}")
          ),
//          appBar: appBarMain(context),
          body: Container(
            child: Column(
              children: <Widget>[
                searchForm(model),
                searchList(model)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchForm(SearchScreenViewModel model){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _searchTextEditingController,
              decoration: textFieldInputDecoration('search'),
            ),
          ),
          GestureDetector(
            onTap: (){
              model.initiateSearch(_searchTextEditingController.text);
            },
            child: Icon(
                Icons.search,
                color: Colors.black38,
                size: 28.0
            ),
          ),

        ],
      ),
    );
  }

  Widget searchList(SearchScreenViewModel model){
    return model.users.length != null ? ListView.builder(
        itemCount: model.users.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return searchTile(model, model.users[index]);
        }) : Container();
  }

  Widget searchTile(SearchScreenViewModel model, User user){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 1),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(user.name, style: mediumTextStyle()),
              Text(user.email, style: mediumTextStyle()),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              model.createChatRoomAndStartConversation(
                  context: context,
                  user: user
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

}
