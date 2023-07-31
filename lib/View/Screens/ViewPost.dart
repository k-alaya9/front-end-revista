import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:get/get.dart';

import '../../Controllers/ViewPostController.dart';
import '../Widgets/Comment.dart';
import '../Widgets/NewComment.dart';
import '../Widgets/post.dart';
class ViewPost extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var v=Get.put(PostController(),permanent: true);
    PostController controller=Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.square(300),
          child: GetX(builder: (PostController controller)=>controller.isAppBarVisible.value
              ? CupertinoNavigationBar(
            leading: Material(
              color: Theme.of(context).backgroundColor,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
            middle: Text('Post'),
          ):
          PreferredSize(
            child: SizedBox.shrink(),
            preferredSize: Size.zero,
          ),
          ),
        ),
        body: NotificationListener(
          onNotification: (value)=>controller.onNotification(value),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              controller:controller. scrollController,
              child: Column(
                children: [
                  Post(
                    authorId: controller.authorId,
                    topics: controller.topics,
                    id: controller.id,
                    username: controller.username,
                    imageUrl: controller.imageUrl,
                    date: controller.date,
                    nickName: controller.nickName,
                    numberOfComments: controller.numberOfComments,
                    textPost: controller.textPost,
                    numberOfLikes: controller.numberOfLikes,
                    url: controller.url,
                    userImage: controller.userImage,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Comments",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              itemCount: controller.Comment.length,
                              itemBuilder: (ctx, index) {
                                // return CommentScreen(
                                //   userImage: ,
                                //   date: ,
                                //   username: ,
                                //   comment: ,
                                //   numberOfLikesOfComments: ,
                                // );
                                return Container();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //newComment
                  comment_Screen(id:controller.id),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}