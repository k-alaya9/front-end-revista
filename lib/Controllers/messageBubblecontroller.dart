import 'dart:convert';
import 'dart:ui';

import 'package:audio_waveforms/audio_waveforms.dart';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:revista/View/Widgets/messageBubble.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:io';
import '../Models/reactionModel.dart';
import 'chatController.dart';

enum Reaction { like, love, lol, wow, sad, angry, none }

class messageBubbleController extends GetxController {
  var id;
  final MessageKey = GlobalKey();
  List selectedMessages = [];
//ToDo add the repiled view
  var reactionView = false.obs;
  var visible = true.obs;
  List<ReactionModel> reactions = [
    ReactionModel(
      reaction: Reaction.like,
      lottie: Image.asset(
        'asset/animations/like.gif',
        fit: BoxFit.fitWidth,
      ),
    ),
    ReactionModel(
      reaction: Reaction.love,
      lottie: Image.asset(
        'asset/animations/love.gif',
        fit: BoxFit.fitWidth,
      ),
    ),
    ReactionModel(
      reaction: Reaction.lol,
      lottie: Image.asset(
        'asset/animations/haha.gif',
        fit: BoxFit.fitWidth,
      ),
    ),
    ReactionModel(
        reaction: Reaction.wow,
        lottie: Image.asset(
          'asset/animations/wow.gif',
          fit: BoxFit.fitWidth,
        )),
    ReactionModel(
      reaction: Reaction.sad,
      lottie: Image.asset('asset/animations/sad.gif', fit: BoxFit.fitWidth),
    ),
    ReactionModel(
      reaction: Reaction.angry,
      lottie: Image.asset('asset/animations/angry.gif', fit: BoxFit.fitWidth),
    ),
  ];
   OverlayEntry? overlayEntry;
  ChatController controller = Get.find();
  late final PlayerController playerController;
  var isPlayed = false.obs;
  var duration = Duration.zero;
  var position = Duration.zero;

  @override
  void onInit() async {
    super.onInit();
    playerController = PlayerController();
    isPlayed.value = playerController.playerState == PlayerState.playing;
  }

  void played(path) async {
    playerController.preparePlayer(path: path!);
    await playerController.startPlayer(finishMode: FinishMode.pause);
    playerController.onCurrentDurationChanged.listen((event) {
      duration = event.seconds;
    });
    // duration = await playerController.getDuration(DurationType.max);
  }

  void pause() async {
    await playerController.pausePlayer();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onCloseOverlay() {
    overlayEntry!.remove();
  }

  showReactionView({
    id,
    selected,
    isMe,
    reaction,
    context,
    tapPosition,
    widget,
  }) {
    var index;
    selected.value = true;
    for(int i=0;i<controller.messages.length;i++)
      if(controller.messages[i].id==id){
        index=i;
      }
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: !isMe?5:null,
        left: isMe?5:null,
        top: 60,
        child: GestureDetector(
          onTap: () => onCloseOverlay(),
          child: Container(
            color: Colors.transparent,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaY: 10, sigmaX: 10, tileMode: TileMode.mirror),
              child: Column(
                crossAxisAlignment: isMe?CrossAxisAlignment.start:CrossAxisAlignment.end,
                children: [
                  Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      height: 50,
                      width: 240,
                      alignment: !isMe ? Alignment.topLeft : Alignment.topRight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          shape: BoxShape.rectangle,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      // child:
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: reactions.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 15 + index * 15,
                              child: FadeInAnimation(
                                  child: InkWell(
                                onTap: () {
                                  reaction.value = reactions[index].reaction;
                                  var map={
                                    "command" : "add_reaction",
                                    "message_id" :'$id',
                                    "reaction_id" : "${index+1}"
                                  };
                                  var body = jsonEncode(map);
                                  controller.channel.sink.add(body);
                                  onCloseOverlay();
                                  selected.value = false;
                                },
                                child: Container(
                                  decoration: reaction.value ==
                                          reactions[index].reaction
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          shape: BoxShape.rectangle,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 9,
                                                color: Colors.grey,
                                                spreadRadius: 3),
                                          ],
                                        )
                                      : null,
                                  width: 30,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: reactions[index].lottie,
                                ),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  widget,
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(DateFormat.jm()
                              .format(DateTime.parse(controller.messages[index].createdAt!)),style: Theme.of(context).textTheme.bodyText1),
                        ),
                        Divider(color: Get.isDarkMode?Colors.white:Colors.black,),
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('reply',style:Theme.of(context).textTheme.bodyText1),
                                Icon(Icons.subdirectory_arrow_left,color: Get.isDarkMode?Colors.white:Colors.black,)
                              ],
                            )),
                        Divider(color: Get.isDarkMode?Colors.white:Colors.black,),
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Forward',style: Theme.of(context).textTheme.bodyText1,),
                                Icon(Icons.reply,color: Get.isDarkMode?Colors.white:Colors.black),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context)!.insert(overlayEntry!);
  }

  reacted(selected) {
    if (selected.value) {
      onCloseOverlay();
      selected.value = false;
    } else {}
  }

  String formatTime(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  getReaction(Reaction r) {
    switch (r) {
      case Reaction.like:
        return Image.asset(
          'asset/animations/ic_like.png',
          fit: BoxFit.contain,
          scale: 0.5,
        );

      case Reaction.love:
        return Image.asset('asset/animations/love2.png',
            fit: BoxFit.contain, scale: 0.5);

      case Reaction.lol:
        return Image.asset('asset/animations/haha2.png',
            fit: BoxFit.contain, scale: 0.5);

      case Reaction.wow:
        return Image.asset('asset/animations/wow2.png',
            fit: BoxFit.contain, scale: 0.5);

      case Reaction.sad:
        return Image.asset('asset/animations/sad2.png',
            fit: BoxFit.contain, scale: 0.5);
      case Reaction.angry:
        return Image.asset('asset/animations/angry2.png',
            fit: BoxFit.contain, scale: 0.5);
      default:
        Container();
        break;
    }
  }

  showImage(photo) {
    Get.dialog(
      Container(
          color: Colors.transparent,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.close,
                            size: 25,
                          ))),
                  InkWell(
                      onTapCancel: () {
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.transparent),
                        child: Image.file(photo),
                      )),
                ],
              ),
            ),
          )),
      useSafeArea: true,
    );
  }
  getIdforRepiledmessage(){
   return id;
  }
  setId(id){
    this.id=id;
  }
}
