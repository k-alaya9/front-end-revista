import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/cameraController.dart';
import 'package:revista/Services/apis/live_api.dart';
import 'package:web_socket_channel/io.dart';

import '../../Services/apis/linking.dart';
import '../../main.dart';
class CameraScreen extends StatefulWidget {
   CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // late cameraController controller;
  late CameraController controller;
  List<CameraDescription>? cameras;
  late IOWebSocketChannel channel;
  var isStreaming=false;
  @override
  void initState(){
    _getAvailableCameras();
    create();
    super.initState();
  }
  create()async{
    var id =await createLiveid();
    var token = sharedPreferences!.getInt('access_id');
    channel = IOWebSocketChannel.connect(
        Uri.parse('ws://$ip/ws/live/$id/'),
        headers: {'Authorization': token});

  }
  Future<void> _getAvailableCameras() async{
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    _initCamera(cameras![0]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Stack(
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: CameraPreview(controller,),
                ),
                Positioned(
                    left: 0,
                    top: 20,
                    child: IconButton(onPressed: () {
                      setState(() {
                        isStreaming=false;
                      });
                      controller.stopImageStream();
                      Get.back();
                    },
                        icon: Icon(
                          Icons.clear, size: 30, color: Colors.white,))),
                Positioned(
                    right: 0,
                    top: 20,
                    child: IconButton(onPressed: () {
                      setState(() {

                      });
                      final lensDirection = controller.description
                          .lensDirection;
                      CameraDescription newDescription;
                      if (lensDirection == CameraLensDirection.front) {
                        newDescription =
                            cameras![0];
                      }
                      else {
                        newDescription =
                            cameras![1];
                      }

                      if (newDescription != null) {
                        _initCamera(newDescription);
                      }
                      else {
                        print('Asked camera not available');
                      }
                    },
                        icon: Icon(Icons.cameraswitch_outlined, size: 30,
                          color: Colors.white,))),
                Positioned(
                  bottom: 10,
                  left: MediaQuery
                      .of(context)
                      .size
                      .width / 2 - 35,
                  child:
                  isStreaming?
                  InkWell(
                    onTap: () {
                      setState(() {
                        isStreaming=false;
                      });
                      controller.stopImageStream();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Center(child: Icon(Icons.stop, color: Theme
                          .of(context)
                          .primaryColor, size: 40,),),
                    ),
                  )
                      :InkWell(
                    onTap: () {
                      setState(() {
                        isStreaming=true;
                      });
                      controller.startImageStream((image) {
                        Uint8List bytes = image.planes[0].bytes;
                        var json=jsonEncode(bytes);
                        channel.sink.add(json);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Center(child: Icon(Icons.video_call, color: Theme
                          .of(context)
                          .primaryColor, size: 40,),),
                    ),
                  ),),
              ]
          )
      ),
    );
  }

  // init camera
  Future<void> _initCamera(CameraDescription description) async {
    setState(() {
      controller =
          CameraController(description, ResolutionPreset.low, enableAudio: true,imageFormatGroup: ImageFormatGroup.bgra8888);
    });
    try{
      await controller.initialize();
      // to notify the widgets that camera has been initialized and now camera preview can be done
      setState((){});
    }catch(e){

    }
  }
  Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    planes.forEach((Plane plane) => allBytes.putUint8List(plane.bytes));
    return allBytes.done().buffer.asUint8List();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
    _initCamera(cameraController.description);
    }
  }
}