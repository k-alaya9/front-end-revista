import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:like_button/like_button.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/replyController.dart';

import '../Widgets/Comment.dart';
import '../Widgets/NewComment.dart';

class ReplyScreen extends StatelessWidget {
  var x = Get.put(ReplyController());
  ReplyController controller = Get.find();

  ReplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: Material(color: Theme.of(context).backgroundColor,
          child: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios_new)),
        ),
        middle: Text('Comment',style: Theme.of(context).textTheme.headline1),
      ),
      body: GetX(builder: (ReplyController controller)=>controller.Replies.isNotEmpty&&controller.id!=null?Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: SingleChildScrollView(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommentScreen(
                  id:controller.Replies[0].comment!.id,
                  comment:controller.Replies[0].comment!.content,
                  username:controller.Replies[0].comment!.author!.user!.username,
                  date:controller.Replies[0].comment!.createdAt,
                  numberOfLikesOfComments:0,
                  userImage:controller.Replies[0].comment!.author!.user!.profileImage),
              Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                  child: Text('Replies',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 30),)),
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
                        return CommentScreen(comment: controller.Replies[index].content,
                            username: controller.Replies[index].author!.user!.username,
                            date: controller.Replies[index].createdAt,
                            numberOfLikesOfComments: 0,
                            userImage: controller.Replies[index].author!.user!.profileImage,
                            id: controller.Replies[index].id);
                      },
                    ),

                  ),
                ],
              ),
            ),
              //new Comment
              Container(
                alignment: Alignment.bottomCenter,
                  child: comment_Screen(id: controller.id.value,isComment: false)),
            ],
          ),
        ),
      ):Center(child: CupertinoActivityIndicator(),),

      ),
    ),
    );
  }
}
