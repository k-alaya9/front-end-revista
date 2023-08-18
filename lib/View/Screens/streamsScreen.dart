import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revista/Services/apis/live_api.dart';
import 'package:revista/main.dart';

const appId = "500f54f570b943f1a9a16f992323e073";
const token = "<-- Insert Token -->";
var channel = Get.arguments['channel'];


class MyAppdd extends StatefulWidget {
  final role;
  const MyAppdd({Key? key, this.role}) : super(key: key);

  @override
  State<MyAppdd> createState() => _MyAppState();
}

class _MyAppState extends State<MyAppdd> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  var frontCamera=true;

  @override
  void initState() {
    super.initState();
    initAgora();
  }
  @override
  void dispose(){
    delete();
    super.dispose();
  }
  void delete()async{
    await _engine.leaveChannel();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );
    if(widget.role) {
      await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();
    }
    else{
      await _engine.setClientRole(role: ClientRoleType.clientRoleAudience);
      await _engine.enableVideo();
      await _engine.startPreview();
    }
    await _engine.joinChannel(
      token: '',
      channelId: channel.toString(),
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(onPressed: ()async{
          if(widget.role){
            var token=sharedPreferences!.getString('access_token');
            await deleteLive(token, channel);
            await _engine.leaveChannel();
          }else{
            await _engine.leaveChannel();
          }
          Get.back();
        }, icon: Icon(Icons.close)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title:  widget.role? IconButton(onPressed: ()async{
          setState(() {
            frontCamera=!frontCamera;
          });
          if(frontCamera) {
            await _engine.enableMultiCamera(enabled: true, config: CameraCapturerConfiguration(cameraDirection: CameraDirection.cameraFront));
          }else{
            await _engine.enableMultiCamera(enabled: true, config: CameraCapturerConfiguration(cameraDirection: CameraDirection.cameraRear));

          }
        }, icon: Icon(Icons.cameraswitch)):Container(),
        actions: [
          IconButton(onPressed: ()async{
            widget.role? await _engine.disableAudio():await _engine.muteLocalAudioStream(true);
          }, icon: Icon(Icons.mic_off))
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
         !widget.role? Center(
            child: _remoteVideo(),
          ):

         Center(
            child: channel!=null?AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
                useAndroidSurfaceView: true
              ),
            ):CupertinoActivityIndicator()
          )
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection:  RtcConnection(channelId: channel.toString()),
        ),
      );
    } else {
      return const CupertinoActivityIndicator();
    }
  }

}