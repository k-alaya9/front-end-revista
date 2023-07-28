import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed_reaction/flutter_feed_reaction.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:lottie/lottie.dart';
import '../../Controllers/chatController.dart';
import '../../Controllers/messageBubblecontroller.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MessageBubble extends StatelessWidget {
  final ValueKey? key;
  final id;
  final  message;
  final  userName;
  final  userImage;
  final urlImage;
  final  isMe;
  final TimeSent;
  final  urlVoice;
  final isTyping;
  final selected;
  final reaction;
  final isReplied;

  MessageBubble({this.message, this.userName, this.userImage, this.urlImage,
       this.isMe, this.TimeSent, this.urlVoice,
      this.key, this.isTyping,required this.id, this.selected, this.reaction,this.isReplied});
  messageBubbleController controller = Get.find();
  ChatController chatController=Get.find();
  var index;
  @override
  Widget build(BuildContext context) {
    if(controller.getIdforRepiledmessage()!=null) {
       index=chatController.messages[controller.getIdforRepiledmessage()];
    }
    return GetX(
        builder: (messageBubbleController controller) => Container(
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
          child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Row(
                    mainAxisAlignment:
                        !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(isReplied)
                            Opacity(
                              key: ValueKey(index),
                              opacity: 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 !isMe? Text('Replied to ${index.isMe?'you':'themself'}'):
                                      Text('you replied to ${!index.isMe?'them':'Yourself'}'),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300]!.withOpacity(0.5),
                                      borderRadius:BorderRadius.circular(25),
                                    ),
                                    padding:
                                    index.urlImage=='' || index.urlImage==null?
                                    EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 16):EdgeInsets.zero,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5 , horizontal:5),
                                    child: Column(
                                      children: [
                                        // voice message
                                        if (index.urlVoice != '')
                                          Container(
                                            child: Row(children: [
                                              IconButton(
                                                  onPressed: (){},
                                                  icon: Icon(Icons.play_arrow),
                                                  color: Colors.white),
                                              AudioFileWaveforms(
                                                size: Size(
                                                    MediaQuery.of(context).size.width /
                                                        3,
                                                    40.0),
                                                playerController:
                                                controller.playerController,
                                                enableSeekGesture: true,
                                                continuousWaveform: true,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                  BorderRadius.circular(25),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    controller.formatTime(
                                                        controller.position),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(color: Colors.white),
                                                  ),
                                                  Text(
                                                    controller.formatTime(
                                                        controller.duration -
                                                            controller.position),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(color: Colors.white),
                                                  ),
                                                ],
                                              )
                                            ]),
                                          ),
                                        //image message
                                        if (index.urlImage != null&&index.urlImage!='')
                                          InkWell(
                                            borderRadius: BorderRadius.circular(25),
                                            splashFactory: NoSplash.splashFactory,
                                            onTap: () {},
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Image.file(
                                                urlImage,
                                                fit: BoxFit.cover,
                                                width:190,
                                              ),
                                            ),
                                          ),
                                        //text message
                                        if (index.message != null)
                                          Text(
                                            index.message!,
                                            style: TextStyle(
                                                color:Colors.black,),
                                            textAlign:
                                            !index.isMe ? TextAlign.end : TextAlign.start,
                                          ),
                                        //is typing or not
                                        index.isTyping&&!index.isMe?Center(child: JumpingDots(
                                          color: Theme.of(context).backgroundColor,
                                          radius: 20,
                                          numberOfDots: 3,
                                          animationDuration: Duration(milliseconds: 200),
                                        ),
                                        ):Container()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          GestureDetector(
                          // behavior: HitTestBehavior.translucent,
                            onLongPressStart:(details) {
                              print('long');
                              print(key!);
                              if(controller.overlayEntry!=null){
                                controller.overlayEntry!.mounted?controller.onCloseOverlay():controller.showReactionView(id: key!.value,selected: selected,context: context,isMe: isMe,
                                    reaction: reaction,
                                    tapPosition: details.globalPosition,
                                  widget:  context.widget,
                                );
                              }else{
                                controller.showReactionView(id: key!.value,selected: selected,context: context,isMe: isMe,
                                    reaction: reaction,
                                    tapPosition: details.globalPosition,
                                  widget:  context.widget,
                                );
                              }
                            },
                            onTap:()=> controller.reacted(selected),
                            onDoubleTap: () {
                              print('double tap');
                              if (reaction.value == Reaction.none) {
                                reaction.value = Reaction.love;
                              } else {
                                reaction.value = Reaction.none;
                              }
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: !isMe
                                    ? Colors.grey[300]
                                    : Theme.of(context).primaryColor,
                                borderRadius: urlImage == null ||urlImage==''
                                    ? BorderRadius.only(
                                        topLeft: isMe
                                            ? Radius.circular(10)
                                            : Radius.circular(55),
                                        topRight: !isMe
                                            ? Radius.circular(10)
                                            : Radius.circular(55),
                                        bottomLeft:Radius.circular(55),
                                        bottomRight: Radius.circular(55)
                                      )
                                    : BorderRadius.circular(25),
                              ),
                              padding:
                                  urlImage=='' || urlImage==null?
                                   EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 16):EdgeInsets.zero,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5 , horizontal: 8),
                              child: Column(
                                crossAxisAlignment: !isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  // voice message
                                  if (urlVoice != ''&& urlVoice !=null)
                                    Container(
                                      child: Row(children: [
                                        IconButton(
                                            onPressed: () async {
                                              print(controller
                                                  .playerController.playerState);
                                              controller.playerController
                                                          .playerState ==
                                                      PlayerState.playing
                                                  ? controller.pause()
                                                  : controller.played(urlVoice);
                                            },
                                            icon: GetX(
                                              builder: (messageBubbleController
                                                      controller) =>
                                                  Icon(controller.isPlayed.value
                                                      ? Icons.pause
                                                      : Icons.play_arrow),
                                            ),
                                            color: Colors.white),
                                        AudioFileWaveforms(
                                          size: Size(
                                              MediaQuery.of(context).size.width /
                                                  3,
                                              40.0),
                                          playerController:
                                              controller.playerController,
                                          enableSeekGesture: true,
                                          continuousWaveform: true,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              controller.formatTime(
                                                  controller.position),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(color: Colors.white),
                                            ),
                                            Text(
                                              controller.formatTime(
                                                  controller.duration -
                                                      controller.position),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(color: Colors.white),
                                            ),
                                          ],
                                        )
                                      ]),
                                    ),
                                  //image message
                                  if (urlImage != null&&urlImage!='')
                                    InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      splashFactory: NoSplash.splashFactory,
                                      onTap: () =>selected.value?(){}: controller.showImage(urlImage),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          urlImage,
                                          fit: BoxFit.cover,
                                          width:190,
                                        ),
                                      ),
                                    ),
                                  //text message
                                  if (message != null)
                                    Text(
                                      message!,
                                      style: TextStyle(
                                          color: !isMe
                                              ? Colors.black
                                              : Colors.white),
                                      textAlign:
                                          !isMe ? TextAlign.end : TextAlign.start,
                                    ),
                                  //is typing or not
                                  isTyping&&!isMe?Center(child: JumpingDots(
                                    color: Theme.of(context).backgroundColor,
                                    radius: 20,
                                    numberOfDots: 3,
                                    animationDuration: Duration(milliseconds: 200),
                                  ),
                                  ):Container()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // user image
                      if(!isMe)
                        Container(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(userImage),
                          ),
                        ),
                    ],
                  ),
                  //reactions display
                  if (reaction.value != Reaction.none && !selected.value)
                    Positioned(
                        left: isMe ? 20 : 0,
                        right: !isMe ? 60 : 0,
                        bottom: 0,
                        child: Align(
                          alignment: isMe?Alignment.bottomLeft:Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              reaction.value = Reaction.none;
                            },
                            child: AnimatedSize(
                              duration: Duration(seconds: 2),
                              child: Container(
                                width:reaction.value != Reaction.none? 15:50,
                                height: reaction.value != Reaction.none?15:50,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child:
                                    controller.getReaction(reaction.value),
                              ),
                            ),
                          ),
                        )),
                ],
              ),
        ),
    );
  }
}