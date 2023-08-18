// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:localize_and_translate/localize_and_translate.dart';
// import 'package:web_socket_channel/io.dart';
//
// import '../../Services/apis/linking.dart';
// import '../../main.dart';
//
// class Streams extends StatefulWidget {
//    Streams({Key? key}) : super(key: key);
//
//   @override
//   State<Streams> createState() => _StreamsState();
// }
//
// class _StreamsState extends State<Streams> {
//   late IOWebSocketChannel channel;
//    bool _isConnected = false;
//
//    void connect(BuildContext context) async {
//      var token = sharedPreferences!.getInt('access_id');
//      channel = IOWebSocketChannel.connect(
//          Uri.parse('ws://$ip/ws/live/74/'),
//          headers: {'Authorization': token});
//      setState(() {
//        _isConnected = true;
//      });
//    }
//
//    void disconnect() {
//
//      setState(() {
//        _isConnected = false;
//      });
//    }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text(translator.translate("Live Video")),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Center(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => connect(context),
//                     child:  Text(translator.translate("Connect")),
//                   ),
//                   ElevatedButton(
//                     onPressed: disconnect,
//                     child:  Text(translator.translate("Disconnect")),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 50.0,
//               ),
//               _isConnected
//                   ? StreamBuilder(
//                 stream:channel.stream,
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const CircularProgressIndicator();
//                   }
//
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return  Center(
//                       child: Text(translator.translate("Connection Closed !")),
//                     );
//                   }
//                   //? Working for single frames/**/
//                   // Decode the base64 encoded JSON data to bytes
//                   final frameData = jsonDecode(snapshot.data)['frame_data']['content'];
//                   var data=jsonDecode(frameData);
//                   print(data);
//                   final decodedData = base64Decode(data);
//                   return Image.memory(
//                   decodedData,
//                     gaplessPlayback: true,
//                     excludeFromSemantics: true,
//                   );
//                 },
//               )
//                   :  Text(translator.translate("Initiate Connection"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "500f54f570b943f1a9a16f992323e073";
const token = "<-- Insert Token -->";
const channel = "hahaha";


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

  @override
  void initState() {
    super.initState();
    initAgora();
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
    }


    await _engine.joinChannel(
      token: '',
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
         !widget.role? Center(
            child: _remoteVideo(),
          ):Center(
            child: _localUserJoined
                ? AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            )
                : const CircularProgressIndicator(),
          ),
          if(widget.role)
            Align(
              alignment: Alignment.bottomCenter,
                child: toolbar()),
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
          connection: const RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
  
  
  Widget toolbar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(onPressed: ()async{await _engine.leaveChannel();}, child: Text('End Stream')),
        ElevatedButton(onPressed: ()async{await _engine.disableAudio();}, child: Text('Mute Myself'))
      ],
    );
  }
}