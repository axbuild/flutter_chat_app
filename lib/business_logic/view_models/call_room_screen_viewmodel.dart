import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chatapp/business_logic/models/call.dart';
import 'package:chatapp/business_logic/models/event.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/settings.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:flutter/cupertino.dart';

class CallRoomScreenViewModel extends ChangeNotifier {

  DatabaseService databaseService = serviceLocator<DatabaseService>();
  List<int> users = <int>[];
  final infoStrings = <String>[];
  bool muted = false;

  void loadData(User user){

  }

  void dispose() {
    // clear users
    users.clear();
    // destroy sdk
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    notifyListeners();
  }


  Future<void> initialize(ClientRole role, String channelName, Room room) async {

    if (Settings().agoraAppId.isEmpty) {

        infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        infoStrings.add('Agora Engine is not starting');
        notifyListeners();
      return;
    }

    await _initAgoraRtcEngine(role);
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = Size(320, 180);
    configuration.bitrate = 140;
    configuration.frameRate = 15;
    await AgoraRtcEngine.setVideoEncoderConfiguration(configuration);
    await AgoraRtcEngine.joinChannel(null, channelName, null, 0);
    databaseService.addCall(room, Call());
    notifyListeners();
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine(ClientRole role) async {
    await AgoraRtcEngine.create(Settings().agoraAppId);
    await AgoraRtcEngine.enableVideo();
    await AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await AgoraRtcEngine.setClientRole(role);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      final info = 'onError: $code';
        infoStrings.add(info);
      notifyListeners();
    };

    AgoraRtcEngine.onJoinChannelSuccess = (
        String channel,
        int uid,
        int elapsed,
        ) {
        final info = 'onJoinChannel: $channel, uid: $uid';
        infoStrings.add(info);
        notifyListeners();
    };

    AgoraRtcEngine.onLeaveChannel = () {
        infoStrings.add('onLeaveChannel');
        users.clear();
        notifyListeners();
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
        final info = 'userJoined: $uid';
        infoStrings.add(info);
        users.add(uid);
        notifyListeners();
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
        final info = 'userOffline: $uid';
        infoStrings.add(info);
        users.remove(uid);
        notifyListeners();
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
        int uid,
        int width,
        int height,
        int elapsed,
        ) {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        infoStrings.add(info);
        notifyListeners();
    };
  }

  void onCallEnd(BuildContext context, Room room) {
//    databaseService.setEvent(room, Local.user, Event());
    Navigator.pop(context);
    notifyListeners();
  }

  void onToggleMute() {
    muted = !muted;
    AgoraRtcEngine.muteLocalAudioStream(muted);
    notifyListeners();
  }

  void onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
    notifyListeners();
  }

}