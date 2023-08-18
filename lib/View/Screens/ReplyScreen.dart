import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:like_button/like_button.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Controllers/replyController.dart';

import '../../Controllers/commentController.dart';
import '../Widgets/Comment.dart';
import '../Widgets/NewComment.dart';

class ReplyScreen extends StatelessWidget {
  var x = Get.put(ReplyController());
  ReplyController Xcontroller = Get.find();

  ReplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var x=Get.put(CommentController());

    CommentController controller = Get.find();
    return SafeArea(child:
    Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: Material(color: Theme.of(context).backgroundColor,
          child: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios_new)),
        ),
        middle: Text(translator.translate("Comment"),style: Theme.of(context).textTheme.headline1),
      ),
      body:  GetX(builder: (ReplyController controller)=>controller.userImage.value.isNotEmpty&&controller.id!=null?
        SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          child:Container(
            padding: EdgeInsets.only(bottom: 70),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if(controller.date!=null)
                    CommentScreen(
                        type: "comment",
                        authorid:controller.authorid.value,
                        id:controller.idcomment.value,
                        comment:controller.comment.value,
                        username:controller.username.value,
                        date:controller.date.value,
                        numberOfLikesOfComments:0,
                        userImage:controller.userImage.value),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(translator.translate("Replies"),style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 30),)),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 6),
                          width: MediaQuery.of(context).size.width-20,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            itemCount: controller.Replies.length,
                            itemBuilder: (ctx, index) {
                              if(controller.Replies!=[]) {
                                return CommentScreen(
                                    type: 'reply',
                                    authorid: controller.Replies[index].author!.id,
                                    comment: controller.Replies[index].content,
                                    username: controller.Replies[index].author!.user!.username,
                                    date: controller.Replies[index].createdAt,
                                    numberOfLikesOfComments: 0,
                                    userImage: controller.Replies[index].author!.user!.profileImage,
                                    id: controller.Replies[index].id);
                              }
                              return Center(child: Text(translator.translate("You don't have any Replies yet")),);

                            },
                          ),

                        ),
                      ],
                    ),
                  ),
                  // //new Comment
                  // Container(
                  //     alignment: Alignment.bottomCenter,
                  //     child: comment_Screen(id: controller.id.value,isComment: false)),
                ],
              ),
            ),
          )
      ):controller.id!=null?Center(child: CupertinoActivityIndicator(),):
      Center(child: Text(translator.translate("You don't have any Replies yet")),),
      ),

      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).backgroundColor,
        child:Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: FlutterMentions(
                    key:controller.mentionsKeyReply,
                    suggestionPosition: SuggestionPosition.Top,
                    onChanged: (value){
                      controller.text!.value=value;
                      var v=value.replaceAll('@','');
                      controller.getSearch(v);
                    },
                    mentions: [
                      Mention(
                          trigger:'@',
                          disableMarkup: true,
                          matchAll: true,
                          data:controller.allData,
                          suggestionBuilder: (data) {
                            print(data);
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      data['photo'],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(data['full_name']),
                                      Text('@${data['display']}'),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                      ),
                    ],
                    cursorColor: Theme.of(context).primaryColor,
                    minLines: 1,
                    //Normal textInputField will be displayed
                    maxLines: 3,
                    // when user presses enter it will adapt to it
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText:  translator.translate("Enter your Reply"),
                      contentPadding: const EdgeInsets.all(10),
                      focusColor: Theme.of(context).primaryColor,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(30)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(30)),),
                  ),
                ),
              ),
              Obx(()=>IconButton(
                disabledColor: Colors.grey,
                onPressed:controller.text!.value.isNotEmpty?()=>controller.send(controller.text!.value, false.obs, Xcontroller.id.value) :null,
                icon: Icon(
                  Icons.send,
                  color:controller.text!.value!=null && controller.text!.value.isNotEmpty? Theme.of(context).primaryColor:Colors.grey,
                ),
              ),

              )
            ],
          ),
        ),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ),
    );
  }
}
