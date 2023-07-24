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
import 'package:revista/Controllers/messageBubblecontroller.dart';
import 'package:revista/Models/message.dart';
import 'package:revista/Services/apis/forgetpassword_api.dart';

class ChatController extends GetxController {
  // messageBubbleController controller=Get.find();
  RxList<Messages> messages = [
    Messages(message: 'hi',
        userName: 'khaled',
        userImage: '',
        urlImage: '',
        isMe: false,
        urlVoice: '',
        TimeSent: DateTime.now(), id: 0,isTyping: false,selected: false.obs,isReplied: false),
    // Messages(message: 'hello',
    //     userName: 'ahmad',
    //     userImage: '',
    //     urlImage: null,
    //     isMe: false,
    //     urlVoice: '',
    //     TimeSent: DateTime.now()),
    // Messages(message: 'how are u',
    //     userName: 'khaled',
    //     userImage: '',
    //     urlImage: null,
    //     isMe: true,
    //     urlVoice: '',
    //     TimeSent: DateTime.now()),
    // Messages(message: 'im fine wby',
    //     userName: 'ahmad',
    //     userImage: '',
    //     urlImage: null,
    //     isMe: false,
    //     urlVoice: '',
    //     TimeSent: DateTime.now()),
  ].obs;
  late RecorderController RecordController; // Initialise
  final recorder = FlutterSoundRecorder();
  List photos = [];
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

  @override
  void onInit() {
    initRecorder();
    fetchPhotos();
    super.onInit();
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
      // messages.add(Messages(
      //     selected: false,
      //     id: messages.length+1,
      //     isTyping: isTyping.value,
      //     message:null,
      //     userName: '',
      //     userImage: '',
      //     urlImage:'',
      //     isMe: true,
      //     TimeSent: DateTime.now(),
      //     urlVoice: ''));
    }
    else {
      isTyping.value = false;
      // messages.remove(Messages(
      //     selected: false,
      //     id: messages.length+1,
      //     isTyping: isTyping.value,
      //     message:null,
      //     userName: '',
      //     userImage: '',
      //     urlImage:'',
      //     isMe: true,
      //     TimeSent: DateTime.now(),
      //     urlVoice: ''));
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
      end: 1000000, // end at a very big index (to get all the assets)
    );
    photos = recentAssets;
  }

  void takePhoto() async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      fileImage.value = File(pickedFile.path);
    }
    messages.add(Messages(
        selected: false,
        id: messages.length,
        isTyping: isTyping.value,
        message:null,
        userName: '',
        userImage: '',
        urlImage:fileImage.value,
        isMe: true,
        TimeSent: DateTime.now(),
        urlVoice: '',
      isReplied: false
    ));
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
      messages.add(Messages(
        selected: false,
          id: messages.length,
          isTyping: isTyping.value,
          message:null,
          userName: '',
          userImage: '',
          urlImage: await selectedPhotos[i].file,
          isMe: true,
          TimeSent: DateTime.now(),
          urlVoice: '',isReplied: false));
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
    messages.add(Messages(
        selected: false,
        id: messages.length,
        isTyping: isTyping.value,
        message: null,
        userName: '',
        userImage: '',
        urlImage: null,
        isMe: true,
        TimeSent: DateTime.now(),
        urlVoice: path,
      isReplied: false,
    ));
  }
  permission() async {
    final permitted = await PhotoManager.requestPermissionExtend();
    if (!permitted.isAuth) return;
  }

  sendMessage(messagex, username,replied){
    messages.add(Messages(
      selected: false,
      id: messages.length,
      isTyping: isTyping.value,
      message: messagex,
        userName: username,
        userImage: '',
        urlImage: null,
        isMe: true,
        TimeSent: DateTime.now(),
        urlVoice: '',
      isReplied: replied.value,
    ));
    message!.value='';
    Textcontroller.clear();
    isTyping.value=false;
    replied.value=false;
  }
}