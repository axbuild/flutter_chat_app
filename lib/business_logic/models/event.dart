import 'base.dart';

class Event implements BaseModel {
  bool isIncomingVideoCall;
  bool isIncomingVoiceCall;
  bool isNewMessage;


  Event({
    this.isIncomingVideoCall = false,
    this.isIncomingVoiceCall = false,
    this.isNewMessage = false
  });

  bool get isNotEmpty =>
      this.isIncomingVideoCall ||
          this.isIncomingVoiceCall ||
            this.isNewMessage;


  @override
  Event.fromMap(Map<String, dynamic> json)
      :isIncomingVideoCall = json['is_incoming_video_call'],
        isIncomingVoiceCall = json['is_incoming_voice_call'],
        isNewMessage = json['is_new_message'];

  @override
  Map<String, dynamic> toMap() => {
    'is_incoming_video_call':isIncomingVideoCall,
    'is_incoming_voice_call':isIncomingVoiceCall,
    'is_new_message':isNewMessage
  };
}