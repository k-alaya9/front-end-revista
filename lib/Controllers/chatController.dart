import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Controllers/messageBubblecontroller.dart';
import 'package:revista/Controllers/visitProfileController.dart';
import 'package:revista/Models/message.dart';
import 'package:revista/Services/apis/forgetpassword_api.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:web_socket_channel/io.dart';

import '../Models/chatModel.dart';
import '../Services/apis/chat_api.dart';
import '../Services/apis/linking.dart';
import '../main.dart';

class ChatController extends GetxController  {
  // messageBubbleController controller=Get.find();
  RxList <Messages> messages=<Messages>[].obs;
  late RecorderController RecordController; // Initialise
  final recorder = FlutterSoundRecorder();
  AutoScrollController scrollController=AutoScrollController(viewportBoundaryGetter: () =>
      Rect.fromLTRB(0, 0, 0, MediaQuery.of(Get.context!).padding.bottom),axis: Axis.vertical,);
  var replied = false.obs;
  List photos = [];
  var id=0.obs;
  var profileId=0.obs;
  var loading=false.obs;
  var isSending=false.obs;
  List<AssetEntity> selectedPhotos = [];
  RxString? message=''.obs;
  RxBool isRecorder = false.obs;
  bool isRecorderReady = false;
  Rx<File> fileImage = File('').obs;
  Rx<File> recordMessage = File('').obs;
  final ImagePicker picker = ImagePicker();
  final TextEditingController Textcontroller = TextEditingController();
  var isTyping = false.obs;
  var picked = false.obs;
   var username=''.obs;
   var imageUrl=''.obs;
  var chatId;
  var stream;
  late IOWebSocketChannel  channel;

  var x=Get.put(visitProfileController());
  visitProfileController visitcontroller=Get.find();
  @override
  void onInit()async {


    var chatId=Get.arguments['chat_id'];

    if(visitcontroller.Username!.value!=''){
      username.value = visitcontroller.Username!.value;
      imageUrl.value=visitcontroller.profileImage!.value;
    }else if(Get.arguments['username']!=null){
      username.value=Get.arguments['username'];
      imageUrl.value =Get.arguments['imageUrl'];
    }else{
      print('done');
      List<chat> chats= await getChats(sharedPreferences!.getString('access_token'));
      for(int i=0;i<chats.length;i++){
        if(chats[i].id==chatId){
          username.value=chats[i].user!.username!;
          imageUrl.value=chats[i].user!.profileImage!;

        }
      }
    }
    List<chat> chats= await getChats(sharedPreferences!.getString('access_token'));
    for(int i=0;i<chats.length;i++)
      if(chats[i].id==chatId)
    profileId.value=chats[i].user!.id!;
    this.chatId=chatId;
    var token = sharedPreferences!.getInt('access_id');
    channel = IOWebSocketChannel.connect(
        Uri.parse('ws://$ip/ws/chat/$chatId/',),
        headers: {'Authorization':token }
    );
    var map = {"command": "fetch_messages"};
    var body = jsonEncode(map);
    channel.sink.add(body);
    channel.stream.listen((event) {
      var map = {"command": "fetch_messages",};
      var body = jsonEncode(map);
      channel.sink.add(body);
          var json=jsonDecode(event);
          var data=Autogenerated.fromJson(json);
          if(data.messages!=null &&messages.length!=data.messages!.length &&data.messages!.isNotEmpty ) {
              messages.assignAll(data.messages!);
          }
    });
    // stream =channel.stream;
    initRecorder();
    fetchPhotos();
    super.onInit();
  }
  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }

  getPhotos(id, selected) {
    print(id);
    print(photos[0].id);
    for (var i = 0; i < photos.length; i++) {
      if (photos[i].id == id) {
        selected.value = !selected.value;
      }
      if (photos[i].id == id && selected.value) {
        selectedPhotos.add(photos[i]);
        print(selectedPhotos);
      }
      if (photos[i].id == id && !selected.value) {
        selectedPhotos.remove(photos[i]);
        print(selectedPhotos);
      }
      picked.value = selectedPhotos.isNotEmpty;
    }
  }

  type(value) {
    message!.value = value;
    if (message!.value.isNotEmpty) {
      isTyping.value = true;
    }
    else {
      isTyping.value = false;
    }
  }

  fetchPhotos() async {
    // Set onlyAll to true, to fetch only the 'Recent' album
    // which contains all the photos/videos in the storage
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    // Now that we got the album, fetch all the assets it contains
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end:100 , // end at a very big index (to get all the assets)
    );
    photos = recentAssets;
  }

   takePhoto() async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      fileImage.value = File(pickedFile.path);
    }
    // messages.add(Messages(
    //     selected: false,
    //     id: messages.length,
    //     isTyping: isTyping.value,
    //     message:null,
    //     userName: '',
    //     userImage: '',
    //     urlImage:fileImage.value,
    //     isMe: true,
    //     TimeSent: DateTime.now(),
    //     urlVoice: '',
    //   isReplied: false
    // ));
    var isFile= fileImage.value;
    var buffer =await isFile!.readAsBytes();
    String base64string = base64.encode(buffer);
    print(base64string);
    var map ={
      "command" : "new_message",
      "message_type" : "image",
      "image" : base64string,
      "reply_id" : 0
    };
    print(map);
    var body=jsonEncode(map);
    channel.sink.add(body);
    Get.back();
  }

  stop() async {
    if (!isRecorderReady) {
      return;
    }
    // final path =await recorder.stopRecorder();
    isRecorder.value = false;
    //   print(path!);
    //
    await RecordController.stop();
  }

  record() async {
    if (!isRecorderReady) {
      return;
    }
    isRecorder.value = true;
    // await recorder.startRecorder(toFile: 'audio');
    await RecordController.record();
  }

  void initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    // await recorder.openRecorder();
    isRecorderReady = true;
    // recorder.setSubscriptionDuration(Duration(milliseconds:  500));

    RecordController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000;

    await RecordController.checkPermission();
  }

  send() async{
    print(selectedPhotos);
    for(int i=0;i<selectedPhotos.length;i++){
     var isFile= await selectedPhotos[i].file;
     var buffer =await isFile!.readAsBytes();
     String base64string = base64.encode(buffer);
     var map ={
       "command" : "new_message",
       "message_type" : "image",
       "image" : base64string,
       "reply_id" : 0
     };
     print(map);
     var body=jsonEncode(map);
     channel.sink.add(body);
    }
    selectedPhotos = [];
    picked.value = selectedPhotos.isNotEmpty;
    Get.back();
  }
  sendRecord() async {
    if (!isRecorderReady) {
      return;
    }
    isRecorder.value = false;
    final path = await RecordController.stop();
    print(path);
    recordMessage.value = File(path!);
    var isFile= recordMessage.value;
    var buffer =await isFile.readAsBytes();
    String base64string = base64.encode(buffer);
    var map ={
      "command" : "new_message",
      "message_type" : "voice_record",
      "voice_record" : base64string,
      "reply_id" : 0
    };
    var body=jsonEncode(map);
    channel.sink.add(body);
  }
  permission() async {
    final permitted = await PhotoManager.requestPermissionExtend();
    if (!permitted.isAuth) return;
  }

  sendMessage(messagex, username,replied){
    var id=sharedPreferences!.getInt('access_id');
    // messages.add(
    //   Messages(
    //     reaction: null,
    //     id: messages[messages.value.length==0?0:messages.value.length-1].id!+1,
    //     createdAt: DateTime.now().toString(),
    //     image: null,
    //     text: messagex,
    //     authorId: id,
    //     voiceRecord: null,
    //     chat: chatId,
    //     selected: false,
    //   ),
    // );
    // messages.add(Messages(
    //   selected: false,
    //   id: messages.length,
    //   isTyping: isTyping.value,
    //   message: messagex,
    //     userName: username,
    //     userImage: '',
    //     urlImage: null,
    //     isMe: true,
    //     TimeSent: DateTime.now(),
    //     urlVoice: '',
    //   isReplied: replied.value,
    // ));
    isSending.value=true;
    var map;
    if(replied.value){
      var replyId=messages[this.id.value].id;
      map={
        "command" : "new_message",
        "message_type" : "text",
        "text" : "$messagex",
        "reply_id": replyId
      };
    }else{
      map={
        "command" : "new_message",
        "message_type" : "text",
        "text" : "$messagex",
        "reply_id": 0
      };
    }
    var body=jsonEncode(map);
    channel.sink.add(body);
    message!.value='';
    this.id.value=0;
    Textcontroller.clear();
    isTyping.value=false;
    replied.value=false;
    isSending.value=false;
    scrollDown();
  }
  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,duration: Duration(milliseconds: 500,),curve: Curves.bounceIn);
  }

    void scrollTo(index) async{
    print('hi');
      await scrollController.scrollToIndex(
       index,
        duration: Duration(milliseconds: 500),
        preferPosition: AutoScrollPosition.middle      );
  }
}