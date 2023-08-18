import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Controllers/commentController.dart';

import '../../Controllers/ViewPostController.dart';
import '../Widgets/Comment.dart';
import '../Widgets/NewComment.dart';
import '../Widgets/post.dart';

class ViewPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var v = Get.put(
      PostController(),
    );
    PostController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.square(300),
          child: GetX(
            builder: (PostController controller) =>
                controller.isAppBarVisible.value
                    ? CupertinoNavigationBar(
                        leading: Material(
                          color: Theme.of(context).backgroundColor,
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_back_ios)),
                        ),
                        middle: Text(translator.translate("Post"),style: Theme.of(context).textTheme.headline1,),
                      )
                    : PreferredSize(
                        child: SizedBox.shrink(),
                        preferredSize: Size.zero,
                      ),
          ),
        ),
        body:  GetX(
          builder: (PostController controller) => controller.username.value.isEmpty &&controller.Comment.isEmpty
              ? Center(
            child: CupertinoActivityIndicator(),
          )
              : NotificationListener(
            onNotification: (value) => controller.onNotification(value),
            child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
                controller: controller.refreshController,
                onRefresh: controller.onRefresh,
                child:SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 60),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Post(
                          saveId: controller.savedId.value,
                          likeId: controller.likeId.value,
                          authorId: controller.authorId.value,
                          topics: controller.topics.value,
                          id: controller.id.value,
                          username: controller.username.value,
                          imageUrl: controller.imageUrl.value,
                          date: DateFormat('yyyy-mm-dd').add_Hm().parse(controller.date.replaceAll('T',' ')),
                          nickName: controller.nickName.value,
                          numberOfComments: controller.numberOfComments,
                          textPost: controller.textPost.value,
                          numberOfLikes:controller.numberOfLikes,
                          url: controller.url.value,
                          userImage: controller.userImage.value,
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
                                      translator.translate("Comments"),
                                      style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 30)
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
                                      return CommentScreen(
                                        type: "comment",
                                        authorid: controller.Comment[index].author!.id,
                                        id: controller.Comment[index].id,
                                        userImage: controller.Comment[index]
                                            .author!.user!.profileImage,
                                        date: controller
                                            .Comment[index].createdAt,
                                        username: controller.Comment[index]
                                            .author!.user!.username,
                                        comment:
                                        controller.Comment[index].content,
                                        numberOfLikesOfComments: 0,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
            ),
          ),
        ),

          floatingActionButton: Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).backgroundColor,
            child:     comment_Screen(id: controller.id.value,isComment: false.obs),),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
