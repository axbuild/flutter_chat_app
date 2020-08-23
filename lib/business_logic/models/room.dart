import 'package:chatapp/business_logic/models/user.dart';

import 'base.dart';

class Room implements BaseModel {
  String sid;
  Map<String, dynamic> users;
  Map<String, dynamic> json;
  String createdBy;
  int time;
  User localUser;
  User remoteUser;



  Room({
    this.sid,
    this.users,
    this.createdBy,
    this.time
  });

  Room.fromMap(Map<String, dynamic> json)
      :sid = json['sid'],
       users = json['users'],
       createdBy = json['created_by'],
       time = json['time'],
       json = json;

  Map<String, dynamic> toMap()  => {
    'sid': sid,
    'users': users,
    'created_by': createdBy,
    'time': time
  };

  void prepareUsersInformation(User localUser){
    if(this.users != null && json['users'] != null){
      json['users'].forEach((k,v){
        if(localUser.sid == k){
         this.localUser = User.fromMap(v);
        }
        else{
          this.remoteUser = User.fromMap(v);
        }
      });
    }
  }

  bool hasUnSeenMessages(){
    if(this.localUser == null) return false;

    String k = 'new_message_'+ this.localUser.sid;
    int count = this.json[k] ?? 0;
    return (count > 0) ? true: false;
  }

  int unSeenMessagesCount(){
    if(this.localUser == null) return 0;

    String k = 'new_message_'+ this.localUser.sid;
    int count = this.json[k] ?? 0;
    return (count > 0) ? count : 0;
  }

  bool isInterlocutorFree(){
    return true;
  }
}