import 'dart:io';
import 'dart:ui' as ui;
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:revista/Controllers/visitProfileController.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../Controllers/chatController.dart';
import '../../Controllers/messageBubblecontroller.dart';
import '../../Services/apis/linking.dart';
import '../../main.dart';
import '../Widgets/messageBubble.dart';
import '../Widgets/photoMessage.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  var replied = false.obs;
  var id;
  var focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    Get.put(messageBubbleController());
    ChatController controller = Get.find();
    messageBubbleController messageController = Get.find();
    // var chatId=Get.arguments['chat_id'];
    // var token = sharedPreferences!.getInt('access_id');
    // print(chatId);
    // visitProfileController controller=Get.find();
    var username = 'khaled ';
    // var imageUrl=controller.profileImage!.value;
    // final channel = IOWebSocketChannel.connect(
    //   Uri.parse('ws://$ip/ws/chat/$chatId/',),
    //     headers: {'Authorization':token }
    // );

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: Material(
          color: Theme.of(context).backgroundColor,
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        middle: Material(
            child: Text(username), color: Theme.of(context).backgroundColor),
        trailing: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: () {},
            child: const CircleAvatar(
              radius: 20,
              // backgroundImage: NetworkImage(imageUrl),
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  // stream: channel.stream,
                  builder: (ctx, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting)
                if (controller.messages.isEmpty) {
                  return const CupertinoActivityIndicator();
                } else {
                  return GetX(
                    builder: (ChatController controller) => GestureDetector(
                      onTap: () => messageController.overlayEntry!.mounted
                          ? messageController.onCloseOverlay()
                          : () {},
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) =>
                            AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            horizontalOffset:
                                !controller.messages[index].isMe ? 50 : -50,
                            child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.horizontal,
                              movementDuration: Duration(milliseconds: 500),
                              onDismissed: (dir) {

                              },
                              confirmDismiss: (direction) async {
                                FocusScope.of(context).requestFocus(focusNode);
                                if(direction == DismissDirection.startToEnd){
                                    replied.value=true;
                              id=controller.messages[index].id;
                              print(id);}
                              },
                              background: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'reply',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                              secondaryBackground: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.arrow_circle_left_outlined),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      DateFormat.jm().format(
                                          controller.messages[index].TimeSent),
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                              child: MessageBubble(
                                key: ValueKey(index),
                                id: index,
                                message: controller.messages[index].message,
                                userName: controller.messages[index].userName,
                                userImage: controller.messages[index].userImage,
                                urlImage: controller.messages[index].urlImage,
                                isMe: controller.messages[index].isMe,
                                TimeSent: controller.messages[index].TimeSent,
                                urlVoice: controller.messages[index].urlVoice,
                                isTyping: false,
                                selected: false.obs,
                                reaction: Reaction.none.obs,
                                isReplied: controller.messages[index].isReplied,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }),
            ),
            GetX(
              builder: (ChatController controller) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: animation.drive(Tween(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0, 0))),
                    child: child,
                  );
                },
                child: controller.isRecorder.value
                    ? Container(
                        key: ValueKey(1),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (controller.isRecorder.value) {
                                    await controller.stop();
                                  } else {
                                    await controller.record();
                                  }
                                },
                                icon: GetX(
                                  builder: (ChatController controller) => Icon(
                                    controller.isRecorder.value
                                        ? Icons.delete
                                        : Icons.mic_rounded,
                                    color: controller.isRecorder.value
                                        ? Colors.red
                                        : Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            AudioWaveforms(
                              size: Size(
                                  MediaQuery.of(context).size.width - 160, 50),
                              enableGesture: true,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Theme.of(context).primaryColor,
                              ),
                              recorderController: controller.RecordController,
                              waveStyle: const WaveStyle(
                                  waveColor: Colors.white,
                                  extendWaveform: true,
                                  showMiddleLine: false),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            StreamBuilder<Duration>(
                                stream: controller
                                    .RecordController.onCurrentDuration,
                                builder: (context, snapshot) {
                                  final duration = snapshot.hasData
                                      ? snapshot.data!
                                      : Duration.zero;
                                  String twoDigits(int n) =>
                                      n.toString().padLeft(2, '0');
                                  final twoDigitsMinutes = twoDigits(
                                      duration.inMinutes.remainder(60));
                                  final twoDigitsSeconds = twoDigits(
                                      duration.inSeconds.remainder(60));
                                  if (controller.isRecorder.value) {
                                    return Text(
                                      '$twoDigitsMinutes : $twoDigitsSeconds',
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                            IconButton(
                              onPressed: controller.sendRecord,
                              icon: const Icon(Icons.arrow_upward,
                                  size: 30, color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    : !replied.value
                        ? Container(
                            key: ValueKey(0),
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    onChanged: (value) =>
                                        controller.type(value),
                                    controller: controller.Textcontroller,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: InkWell(
                                          onTap: controller.takePhoto,
                                          splashFactory: NoSplash.splashFactory,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.camera_alt,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      hintText: 'Send a message...',
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      focusColor:
                                          Theme.of(context).primaryColor,
                                      contentPadding: const EdgeInsets.all(10),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                  )),
                                  GetX(
                                    builder: (ChatController controller) =>
                                        AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      reverseDuration:
                                          const Duration(milliseconds: 500),
                                      transitionBuilder: ((child, animation) {
                                        return SlideTransition(
                                          child: child,
                                          position: animation.drive(
                                            Tween(
                                              begin: const Offset(1, 0),
                                              end: const Offset(0, 0),
                                            ),
                                          ),
                                        );
                                      }),
                                      child: controller.isTyping.value
                                          ? TextButton(
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                if (controller
                                                    .message!.value.isNotEmpty) {
                                                  controller.sendMessage(
                                                      controller.message!.value,
                                                      username,replied);
                                                }
                                              },
                                              child: Text(
                                                'Send',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ))
                                          : Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () async {
                                                          if (controller
                                                              .isRecorder
                                                              .value) {
                                                            await controller
                                                                .stop();
                                                          } else {
                                                            await controller
                                                                .record();
                                                          }
                                                        },
                                                        icon: GetX(
                                                            builder:
                                                                (ChatController
                                                                        controller) =>
                                                                    Icon(
                                                                      controller
                                                                              .isRecorder
                                                                              .value
                                                                          ? Icons
                                                                              .stop_circle_outlined
                                                                          : Icons
                                                                              .mic_rounded,
                                                                      color: controller
                                                                              .isRecorder
                                                                              .value
                                                                          ? Theme.of(context)
                                                                              .primaryColor
                                                                          : Colors
                                                                              .black,
                                                                      size: 30,
                                                                    ))),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      controller.fetchPhotos();
                                                      Get.bottomSheet(
                                                        MediaQuery(
                                                          data: MediaQueryData
                                                              .fromWindow(
                                                                  WidgetsBinding
                                                                      .instance
                                                                      .window),
                                                          child: SafeArea(
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  width: 60,
                                                                  height: 5,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(12.0))),
                                                                ),
                                                                Container(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    child: Text(
                                                                      'Gallery',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline1,
                                                                    )),
                                                                Expanded(
                                                                  child:
                                                                      Scaffold(
                                                                    body:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          GridView
                                                                              .builder(
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            physics:
                                                                                const ScrollPhysics(),
                                                                            gridDelegate:
                                                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                                              // A grid view with 3 items per row
                                                                              crossAxisCount: 3,
                                                                            ),
                                                                            itemCount:
                                                                                controller.photos.length,
                                                                            itemBuilder:
                                                                                (_, index) {
                                                                              return AssetThumbnail(
                                                                                asset: controller.photos[index],
                                                                                id: controller.photos[index].id,
                                                                                selected: false.obs,
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    extendBody:
                                                                        true,
                                                                    persistentFooterButtons: [
                                                                      GetX(
                                                                          builder: (ChatController controller) =>
                                                                              AnimatedSwitcher(
                                                                                duration: Duration(milliseconds: 500),
                                                                                child: controller.picked.value
                                                                                    ? InkWell(
                                                                                        onTap: () => controller.send(),
                                                                                        child: Align(
                                                                                          alignment: Alignment.bottomCenter,
                                                                                          child: Container(
                                                                                            key: ValueKey(1),
                                                                                            alignment: Alignment.center,
                                                                                            width: MediaQuery.of(context).size.width,
                                                                                            height: 50,
                                                                                            decoration: BoxDecoration(
                                                                                              color: Theme.of(context).primaryColor,
                                                                                            ),
                                                                                            child: Text(
                                                                                              'Send',
                                                                                              style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : Container(
                                                                                        key: ValueKey(0),
                                                                                      ),
                                                                              )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        elevation: 10,
                                                        backgroundColor: Theme
                                                                .of(context)
                                                            .backgroundColor,
                                                        persistent: true,
                                                        isScrollControlled:
                                                            true,
                                                        enableDrag: true,
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          25),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          25)),
                                                        ),
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.photo_outlined,
                                                      size: 30,
                                                    )),
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        : Container(
                            key: ValueKey(0),
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.all(5),
                            height: 110,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Replaying to ${controller.messages[id].isMe ? 'yourself' : username}',
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          controller.messages[id].message,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          replied.value=false;
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          size: 25,
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: TextField(
                                      onChanged: (value) =>
                                          controller.type(value),
                                      autofocus: true,
                                      focusNode: focusNode,
                                      controller: controller.Textcontroller,
                                      decoration: InputDecoration(
                                        hintText: 'Send a message...',
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        focusColor:
                                            Theme.of(context).primaryColor,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                    )),
                                    GetX(
                                      builder: (ChatController controller) =>
                                          AnimatedSwitcher(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              reverseDuration: const Duration(
                                                  milliseconds: 500),
                                              transitionBuilder:
                                                  ((child, animation) {
                                                return SlideTransition(
                                                  child: child,
                                                  position: animation.drive(
                                                    Tween(
                                                      begin:
                                                          const Offset(1, 0),
                                                      end: const Offset(0, 0),
                                                    ),
                                                  ),
                                                );
                                              }),
                                              child: controller.isTyping.value
                                                  ? TextButton(
                                                      onPressed: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        if (controller
                                                            .message!
                                                            .value
                                                            .isNotEmpty) {
                                                          controller
                                                              .sendMessage(
                                                                  controller
                                                                      .message!
                                                                      .value,
                                                                  username,replied);
                                                          if(id!=null)
                                                          messageController.setId(id);
                                                        }
                                                      },
                                                      child: Text(
                                                        'Send',
                                                        style:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyText1,
                                                      ))
                                                  : Container()),
                                    ),
                                  ],
                                ),
                              ],
                            )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
