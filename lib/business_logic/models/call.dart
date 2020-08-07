import 'base.dart';

class Call  implements BaseModel {
  String callerId;
  String callerName;
  String callerPic;
  String receiverId;
  String receiverName;
  String receiverPic;
  String channelId;
  bool hasDialled;

  Call({
    this.callerId,
    this.callerName,
    this.callerPic,
    this.receiverId,
    this.receiverName,
    this.receiverPic,
    this.channelId,
    this.hasDialled,
  });


  Call.fromMap(Map<String, dynamic> callMap) {
    this.callerId = callMap["caller_id"];
    this.callerName = callMap["caller_name"];
    this.callerPic = callMap["caller_pic"];
    this.receiverId = callMap["receiver_id"];
    this.receiverName = callMap["receiver_name"];
    this.receiverPic = callMap["receiver_pic"];
    this.channelId = callMap["channel_id"];
    this.hasDialled = callMap["has_dialled"];
  }

  Map<String, dynamic> toMap() => {
    "caller_id": this.callerId,
    "caller_name": this.callerName,
    "caller_pic": this.callerPic,
    "receiver_id": this.receiverId,
    "receiver_name": this.receiverName,
    "receiver_pic": this.receiverPic,
    "channel_id": this.channelId,
    "has_dialled": this.hasDialled
  };

}
