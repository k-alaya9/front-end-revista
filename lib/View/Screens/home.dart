import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Controllers/postController.dart';
import 'package:revista/Models/topic.dart';
import '../../Controllers/drawerController.dart';
import '../../Controllers/notifications_controller.dart';
import '../Widgets/drawer.dart';
import '../Widgets/drawerWidget.dart';
import '../Widgets/post.dart';
import '../Widgets/searchBar.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var x = Get.put(viewPostController());
    viewPostController controller = Get.find();
    return Scaffold(
      appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        leading: Material(
          color: Theme.of(context).backgroundColor,
          child: DrawerWidget(),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        middle: Container(
          margin: EdgeInsets.only(top: 3,bottom: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage('asset/image/logo.png'),isAntiAlias: true,filterQuality: FilterQuality.high,fit: BoxFit.contain)
          ),
        ),
        trailing: GetX(builder: (notificationsController ncontroller)=>
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: (){
                  Get.toNamed('/notification');
                },
                child: Stack(

                  clipBehavior: Clip.none,
                  children: [
                  Icon(Icons.notifications_active_outlined),
                    if(ncontroller.notifiction_number.value!=0)
                      Positioned(
                        right: -8,
                        top: -7,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(child: Text((ncontroller.notifiction_number.value).toInt().toString(),style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white)),),
                        ),
                      ),
                  ],
                ),
              ),
            ),

        ),
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoad,
          child: GetX(
            builder: (viewPostController controller) => ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: controller.Posts.length,
              itemBuilder: (ctx, index) {
                var name = controller.Posts[index].author!.user!.firstName! +
                    " "+
                    controller.Posts[index].author!.user!.lastName!;
                var date = DateFormat('yyyy-mm-dd')
                    .parse(controller.Posts[index].createdAt!);
                // print(controller.Posts[index].topics);
                if (controller.Posts.isNotEmpty) {
                  return Column(
                    children: [
                      Post(
                        saveId: controller.Posts[index].saveId,
                        likeId: controller.Posts[index].likeId,
                        authorId: controller.Posts[index].author!.id!,
                        topics:controller.Posts[index].topics!,
                        id: controller.Posts[index].id,
                        imageUrl: controller.Posts[index].image,
                        username:
                            controller.Posts[index].author!.user!.username,
                        date: date,
                        url: controller.Posts[index].link,
                        numberOfLikes: controller.Posts[index].likesCount.obs,
                        textPost: controller.Posts[index].content,
                        nickName: name,
                        numberOfComments: controller.Posts[index].commentsCount
                            .toString()
                            .obs,
                        userImage:
                            controller.Posts[index].author!.user!.profileImage,
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
                    child: Text(translator.translate("u dont ahve any posts")),
                  );
                }
              },
            ),
          )),
    );
  }
}
