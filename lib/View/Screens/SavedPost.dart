

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/View/Widgets/drawerWidget.dart';

import '../../Controllers/savedPostController.dart';
import '../Widgets/post.dart';

class SavedPost extends StatelessWidget {
  const SavedPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(savedPostController());
    savedPostController controller=Get.find();
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: Material(
          color: Theme.of(context).backgroundColor,
          child: DrawerWidget(),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        middle: Text('SavedPosts',style: Theme.of(context).textTheme.headline1),
      ),
      body:  SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          child: GetX(
            builder: (savedPostController controller) => ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: controller.Posts.length,
              itemBuilder: (ctx, index) {
                // print(controller.Posts[index].topics);
                if (controller.Posts.isNotEmpty) {
                  return Column(
                    children: [
                      Post(
                        saveId: controller.Posts[index].post!.savedPostId!,
                        likeId: controller.Posts[index].post!.likeId!,
                        authorId: controller.Posts[index].post!.author!,
                        topics:controller.Posts[index].post!.topicsDetails,
                        id: controller.Posts[index].post!.id,
                        imageUrl: controller.Posts[index].post!.image,
                        username:
                        controller.Posts[index].post!.author!.user!.username,
                        date:DateFormat('yyyy-mm-dd')
                            .parse(controller.Posts[index].post!.createdAt!) ,
                        url: controller.Posts[index].post!.link,
                        numberOfLikes: controller.Posts[index].post!.likesCount.obs,
                        textPost: controller.Posts[index].post!.content,
                        nickName: controller.Posts[index].post!.author!.user!.firstName!+
                            ' '+
                            controller.Posts[index].post!.author!.user!.lastName!,
                        numberOfComments: controller.Posts[index].post!.commentsCount
                            .toString()
                            .obs,
                        userImage:
                        controller.Posts[index].post!.author!.user!.profileImage,
                        key: ValueKey(controller.Posts[index].id),
                      ),
                      Container(
                          color: Theme.of(context).backgroundColor,
                          child: Divider(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          )),
                    ],
                  );
                } else {
                  return Center(
                    child: Text('u dont Saved any post yet'),
                  );
                }
              },
            ),
          )),
    );
  }
}
