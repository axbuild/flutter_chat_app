import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  Stream chatMessagesStream;

  Widget ChatMessageList(){
      return StreamBuilder(
        stream: chatMessagesStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return MessageTile(
                  snapshot.data.documents[index].data["message"],
                    snapshot.data.documents[index].data["sendBy"] == Constants.myName
                );
              }) : Container();
        },
      );
  }

  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: <Widget>[
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: textFieldInputDecoration('Message...'),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        sendMessage();
                      },
                      child: Icon(
                          Icons.send,
                          color: Colors.black38,
                          size: 28.0
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0 : 24,  right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
            color: isSendByMe ? Colors.blueGrey : Colors.blue,
            borderRadius: isSendByMe ?
              BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23),
              ) :
              BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23),
              )
        ),
        child: Text(message, style: TextStyle(
          color: Colors.white,
          fontSize: 17
        ),),
      ),
    );
  }
}
