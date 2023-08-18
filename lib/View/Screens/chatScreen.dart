import 'dart:convert';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Models/message.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../Controllers/chatController.dart';
import '../../Controllers/messageBubblecontroller.dart';
import '../../Controllers/visitProfileController.dart';
import '../../Services/apis/linking.dart';
import '../../main.dart';
import '../Widgets/messageBubble.dart';
import '../Widgets/photoMessage.dart';
import '../Widgets/reportWidget.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  var x = Get.put(ChatController(),);

  var y = Get.put(messageBubbleController());

  // var id;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.find();
    messageBubbleController messageController = Get.find();
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
            color: Theme.of(context).backgroundColor,
            child: GetX(builder: (ChatController controller) =>Text(controller.username.value),)),
        trailing: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: () {
              Get.bottomSheet(
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                  CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(controller.imageUrl.value),),
                  SizedBox(height: 10,),
                  Text(controller.username.value),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        createContainer(icon: Icons.call,text: "Voice Call",func: (){print('call');}),
                        createContainer(icon: Icons.video_call_rounded,text: "Video Call",func: (){print('video');}),
                        createContainer(icon: Icons.report_problem_outlined,text: "Report",func: (){ Get.defaultDialog(
                          content: Report(type: "chat",id: controller.profileId.value),
                          title: "Report",
                          contentPadding: EdgeInsets.zero,
                        );}),
                        createContainer(icon: Icons.person,text: "Profile",func: (){Get.toNamed('/visitProfile',arguments: {
                          'id': controller.profileId.value,
                        });}),
                      ],
                    )
                  ],
                ),
                backgroundColor: Theme.of(context).backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                enableDrag: true,
                isScrollControlled: true,
                ignoreSafeArea: true,
              );
            },
            child: GetX(builder: (ChatController controller)=>CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(controller.imageUrl.value),
            ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:Obx(() {
              if (controller.messages.value.isEmpty) {
                return Container();
              } else {
                return SmartRefresher(
                  controller: controller.refreshController,
                   onRefresh: controller.onRefresh,
                  enablePullUp: false,
                  enablePullDown: true,
                  header: ClassicHeader(refreshingIcon: CupertinoActivityIndicator(),idleText: '',completeText: '',completeIcon: Container(),idleIcon: Container(),releaseText: '',releaseIcon: Container(),refreshingText: '',completeDuration: Duration(milliseconds: 0)),
                  child: ListView.builder(
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    itemCount: controller.loading.value? controller.messages.length +1:controller.messages.length,
                    itemBuilder: (context, index) {
                      var isMe = controller.messages[index].authorId ==
                          sharedPreferences!.getInt('access_id')
                          ? true
                          : false;
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          horizontalOffset: !isMe ? 50 : -50,
                          child: Dismissible(
                            // behavior: HitTestBehavior.opaque,
                            key: UniqueKey(),
                            direction: DismissDirection.horizontal,
                            movementDuration: Duration(milliseconds: 500),
                            onDismissed: (dir) {},
                            confirmDismiss: (direction) async {
                              FocusScope.of(context).requestFocus(focusNode);
                              if (direction == DismissDirection.startToEnd) {
                                controller.replied.value = true;
                                controller.id.value = index;
                              }
                            },
                            background: Container(
                              child: Row(
                                children: [
                                  Text(
                                    "reply",
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
                                    DateFormat.jm().format(DateTime.parse(
                                        controller.messages[index].createdAt!)),
                                    style:
                                    Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            child: AutoScrollTag(
                              key: ValueKey(index),
                              index: index,
                              controller: controller.scrollController,
                              child: MessageBubble(
                                key: ValueKey(index),
                                id: controller.messages[index].id,
                                message: controller.messages[index].text,
                                userName: '',
                                userImage: isMe ? '' : controller.imageUrl.value,
                                urlImage: controller.messages[index].image,
                                isMe: isMe,
                                TimeSent: controller.messages[index].createdAt,
                                urlVoice: controller.messages[index].voiceRecord,
                                isTyping: false,
                                selected: false.obs,
                                reaction: controller.messages[index].reaction == 1
                                    ? Reaction.like.obs
                                    : controller.messages[index].reaction == 2
                                    ? Reaction.love.obs
                                    : controller.messages[index].reaction == 4
                                    ? Reaction.wow.obs
                                    : controller.messages[index]
                                    .reaction ==
                                    3
                                    ? Reaction.lol.obs
                                    : controller.messages[index]
                                    .reaction ==
                                    5
                                    ? Reaction.sad.obs
                                    : controller.messages[index]
                                    .reaction ==
                                    6
                                    ? Reaction.angry.obs
                                    : Reaction.none.obs,
                                replyId: controller.messages[index].reply_id,
                                isSending: false.obs,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                );
              }
            }),
          ),
          GetX(
            builder: (ChatController controller) {
              return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              reverseDuration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: animation.drive(Tween(
                      begin: const Offset(0.0, 1.0), end: const Offset(0, 0))),
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
                              stream:
                                  controller.RecordController.onCurrentDuration,
                              builder: (context, snapshot) {
                                final duration = snapshot.hasData
                                    ? snapshot.data!
                                    : Duration.zero;
                                String twoDigits(int n) =>
                                    n.toString().padLeft(2, '0');
                                final twoDigitsMinutes =
                                    twoDigits(duration.inMinutes.remainder(60));
                                final twoDigitsSeconds =
                                    twoDigits(duration.inSeconds.remainder(60));
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
                  : !controller.replied.value
                      ? Container(
                          key: ValueKey(0),
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(5),
                          child: SingleChildScrollView(
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextField(
                                  onChanged: (value) => controller.type(value),
                                  controller: controller.Textcontroller,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(5),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: InkWell(
                                        onTap: controller.takePhoto,
                                        splashFactory: NoSplash.splashFactory,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).accentColor,
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
                                    hintText: "Message...",
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    suffixIcon: GetX(
                                      builder: (ChatController controller) =>
                                          AnimatedSwitcher(
                                            duration: const Duration(milliseconds: 500),
                                            reverseDuration:
                                            const Duration(milliseconds: 500),
                                            transitionBuilder: ((child, animation) {
                                              return SlideTransition(
                                                child: child,
                                                position: animation.drive(
                                                  Tween(
                                                    begin: const Offset(0, 1),
                                                    end: const Offset(0, 0),
                                                  ),
                                                ),
                                              );
                                            }),
                                            child: controller.isTyping.value
                                                ? TextButton(
                                                onPressed: () {
                                                  FocusScope.of(context).unfocus();
                                                  if (controller
                                                      .message!.value.isNotEmpty) {
                                                    controller.sendMessage(
                                                        controller.message!.value,
                                                        controller.username,
                                                        controller.replied);
                                                  }
                                                },
                                                child: Text(
                                                  "Send",

                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ))
                                                : Row(
                                               mainAxisAlignment: MainAxisAlignment.end,
                                               mainAxisSize: MainAxisSize.min,
                                               children: [
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () async {
                                                          if (controller
                                                              .isRecorder.value) {
                                                            await controller
                                                                .stop();
                                                          } else {
                                                            await controller
                                                                .record();
                                                          }
                                                        },
                                                        icon: GetX(
                                                            builder: (ChatController
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
                                                                      ? Theme.of(
                                                                      context)
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
                                                      var isScrolled=false.obs;
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      controller.fetchPhotos();
                                                      Get.bottomSheet(
                                                        SafeArea(
                                                          child: Container(
                                                            height: isScrolled.value?MediaQuery.of(context).size.height/2:MediaQuery.of(context).size.height-40,
                                                            child: Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onVerticalDragStart: (val){
                                                                    isScrolled.value=true;
                                                                  },
                                                                  onVerticalDragEnd: (val){
                                                                    isScrolled.value=false;
                                                                  },
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
                                                                          const EdgeInsets
                                                                              .all(10),
                                                                          child: Text(
                                                                            "Gallery",
                                                                            style: Theme.of(
                                                                                context)
                                                                                .textTheme
                                                                                .headline1,
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                    child: Text(
                                                                      "Gallery",
                                                                      style: Theme.of(
                                                                          context)
                                                                          .textTheme
                                                                          .headline1,
                                                                    )),
                                                                Expanded(
                                                                  child: Scaffold(
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
                                                                              crossAxisCount:
                                                                              3,
                                                                            ),
                                                                            itemCount: controller
                                                                                .photos
                                                                                .length,
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
                                                                          builder: (ChatController
                                                                          controller) =>
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
                                                                                        "Send",
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
                                                        backgroundColor:
                                                        Theme.of(context)
                                                            .backgroundColor,
                                                        persistent: true,
                                                        isScrollControlled: true,
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
                                                    icon:  Icon(
                                                      Icons.insert_photo_outlined,
                                                      color: Colors.black,
                                                      size: 30,
                                                    )),
                                                const SizedBox(width: 5,)
                                              ],
                                            ),
                                          ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    focusColor: Theme.of(context).primaryColor,
                                    // contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                )),
                              ],
                            ),
                          ))
                      : Container(
                          key: ValueKey(2),
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
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Replaying to ${controller.messages[controller.id.value].authorId == sharedPreferences!.getInt('access_id') ? "yourself" : controller.username}",
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          controller.messages[controller.id.value].text!,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        controller.replied.value = false;
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
                                    cursorColor: Theme.of(context).primaryColor,
                                    controller: controller.Textcontroller,
                                    decoration: InputDecoration(
                                      hintText: "Message...",
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      focusColor:
                                          Theme.of(context).primaryColor,
                                      contentPadding: const EdgeInsets.all(10),
                                      border: OutlineInputBorder(
                                          borderSide:BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:BorderSide.none,
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
                                                      if (controller.message!
                                                          .value.isNotEmpty) {
                                                        controller.sendMessage(
                                                            controller
                                                                .message!.value,
                                                            controller.username,
                                                            controller.replied);
                                                      //   if (id != null)
                                                      //     messageController
                                                      //         .setId(id);
                                                      }
                                                    },
                                                    child: Text(
                                                      "Send",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                    ))
                                                : Container()),
                                  ),
                                ],
                              ),
                            ],
                          )),
            );
            },
          ),
        ],
      ),
    );
  }
  createContainer({icon,text,func}){
    var context=Get.context!;
    return InkWell(
      onTap: func,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).backgroundColor,
        ),
        child: Column(
          children: [
            Icon(icon,color: Theme.of(context).primaryColor,),
            SizedBox(height: 5,),
            Text(text,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).primaryColor),)
          ],
        ),
      ),
      splashFactory: NoSplash.splashFactory,
    );
  }
}
