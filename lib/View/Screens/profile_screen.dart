import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../Controllers/ProfileController.dart';
import '../../Controllers/notifications_controller.dart';
import '../Widgets/drawerWidget.dart';
import '../Widgets/post.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.zero,
          leading: Material(
            color: Theme.of(context).backgroundColor,
            child: DrawerWidget(),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          middle: Text(translator.translate("Profile"), style: Theme.of(context).textTheme.headline1),
        ),
        body: Obx(() {
          if (controller.profileImage.value.isNotEmpty &&
              controller.CoverImage.value.isNotEmpty) {
            return SmartRefresher(
              onLoading: null,
              header:
                  ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
              footer: null,
              onRefresh: controller.onRefresh,
              enablePullUp: false,
              controller: controller.refreshController,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GetX(
                      builder: (ProfileController controller) => Column(
                        children: [
                          GestureDetector(
                            onTap: () => controller
                                .showImage(controller.CoverImage.value),
                            onLongPress: () => Get.bottomSheet(
                              controller.bottomsheet(2),
                              elevation: 10,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40),
                                      topLeft: Radius.circular(40))),
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              enterBottomSheetDuration:
                                  const Duration(milliseconds: 500),
                              exitBottomSheetDuration:
                                  const Duration(milliseconds: 500),
                            ),
                            child: GetX(
                              builder: (ProfileController controller) =>
                                  Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          controller.CoverImage.value),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 80),
                                        child: Text(
                                          controller.firstname.value +
                                              ' ' +
                                              controller.lastName.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(
                                              controller.Username.value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(color: Colors.grey),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 33,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                shape: BoxShape.circle),
                                            child: IconButton(
                                              icon: Icon(Icons.edit,
                                                  size: 20,
                                                  color: Colors.white),
                                              onPressed: () {
                                                Get.toNamed('/EditProfile');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      controller.bio.value,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        splashFactory: NoSplash.splashFactory,
                                        onTap: () {
                                          Get.toNamed('/followers');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          // decoration: BoxDecoration(
                                          //     color: Colors.grey[300],
                                          //     shape: BoxShape.rectangle,
                                          //     borderRadius:
                                          //         BorderRadius.circular(20)),
                                          child: Column(
                                            children: [
                                              Text(
                                                translator.translate("Followers"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    ,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                controller.followers.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    ,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashFactory: NoSplash.splashFactory,
                                        onTap: () {
                                          Scrollable.ensureVisible(
                                              controller
                                                  .ListKey.currentContext!,
                                              duration: Duration(seconds: 1));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          // decoration: BoxDecoration(
                                          //     color: Colors.grey[300],
                                          //     shape: BoxShape.rectangle,
                                          //     borderRadius:
                                          //         BorderRadius.circular(20)),
                                          child: Column(
                                            children: [
                                              Text(
                                                translator.translate( "Posts"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    ,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                controller.numberOfPosts.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    ,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashFactory: NoSplash.splashFactory,
                                        onTap: () {
                                          Get.toNamed('/following');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          // decoration: BoxDecoration(
                                          //     color: Colors.grey[300],
                                          //     shape: BoxShape.rectangle,
                                          //     borderRadius:
                                          //         BorderRadius.circular(20)),
                                          child: Column(
                                            children: [
                                              Text(
                                                translator.translate("Following"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    ,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                controller.following.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    ,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Column(
                                    key: controller.ListKey,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: IconButton(
                                              onPressed: () =>
                                                  Get.toNamed('/CreatePost'),
                                              icon: Icon(
                                                Icons.add,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: controller
                                                        .postView.value
                                                    ? Border(
                                                        bottom: BorderSide(
                                                            width: 4,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor))
                                                    : null),
                                            child: TextButton(
                                              style: ButtonStyle(
                                                  splashFactory:
                                                      NoSplash.splashFactory),
                                              onPressed: () =>
                                                  controller.switchViewPost(),
                                              child: Text(translator.translate("Posts"),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                          color: controller
                                                                  .postView
                                                                  .value
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Theme.of(context).accentColor)),
                                            ),
                                          ),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //       border: !controller
                                          //               .postView.value
                                          //           ? Border(
                                          //               bottom: BorderSide(
                                          //                   width: 4,
                                          //                   color: Theme.of(
                                          //                           context)
                                          //                       .primaryColor))
                                          //           : null),
                                          //   child: TextButton(
                                          //     style: ButtonStyle(
                                          //         splashFactory:
                                          //             NoSplash.splashFactory),
                                          //     onPressed: () => controller
                                          //         .switchViewSavedPosts(),
                                          //     child: Text(translator.translate("Saved"),
                                          //         style: Theme.of(context)
                                          //             .textTheme
                                          //             .headline1!
                                          //             .copyWith(
                                          //                 color: !controller
                                          //                         .postView
                                          //                         .value
                                          //                     ? Theme.of(
                                          //                             context)
                                          //                         .primaryColor
                                          //                     : Theme.of(context).accentColor)),
                                          //   ),
                                          // ),
                                          Row(
                                            children: [
                                              Container(
                                                child: IconButton(
                                                  onPressed: () => controller
                                                      .switchViewVertical(),
                                                  icon: Icon(
                                                    Icons
                                                        .vertical_split_outlined,
                                                    color: controller.View.value
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Theme.of(context).accentColor,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                              // Container(
                                              //   child: IconButton(
                                              //     onPressed: () => controller
                                              //         .switchViewHorizontal(),
                                              //     icon: Icon(
                                              //       Icons
                                              //           .horizontal_split_outlined,
                                              //       color: !controller
                                              //               .View.value
                                              //           ? Theme.of(context)
                                              //               .primaryColor
                                              //           :Theme.of(context).accentColor,
                                              //       size: 25,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      AnimatedSwitcher(
                                        duration: Duration(milliseconds: 1000),
                                        reverseDuration:
                                            Duration(milliseconds: 1000),
                                        transitionBuilder: (child, animation) {
                                          return SlideTransition(
                                            position: animation.drive(Tween(
                                                begin: Offset(1.0, 0.0),
                                                end: Offset(0, 0))),
                                            child: child,
                                          );
                                        },
                                        child: controller.View.value
                                            ? ListView.builder(
                                                physics: ScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                controller.postView.value? controller.Posts.length:controller.SavedPost.length,
                                                itemBuilder: (ctx, index) {
                                                  var name = controller.Posts[index].author!.user!.firstName! +
                                                      controller.Posts[index].author!.user!.lastName!;
                                                  var date = DateFormat('yyyy-mm-dd')
                                                      .parse(controller.Posts[index].createdAt!);
                                                  print(controller.SavedPost.length);
                                                  return AnimatedSwitcher(
                                                      duration: Duration(
                                                          milliseconds: 1000),
                                                      reverseDuration: Duration(
                                                          milliseconds: 1000),
                                                      child:
                                                      controller.postView.value?Post(
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
                                                      ):Post(
                                                        saveId: controller.SavedPost[index].post!.savedPostId!,
                                                        likeId: controller.SavedPost[index].post!.likeId!,
                                                        authorId: controller.SavedPost[index].post!.author!,
                                                        topics:controller.SavedPost[index].post!.topicsDetails,
                                                        id: controller.SavedPost[index].post!.id,
                                                        imageUrl: controller.SavedPost[index].post!.image,
                                                        username:
                                                        controller.SavedPost[index].post!.author!.user!.username,
                                                        date:DateFormat('yyyy-mm-dd')
                                                            .parse(controller.SavedPost[index].post!.createdAt!) ,
                                                        url: controller.SavedPost[index].post!.link,
                                                        numberOfLikes: controller.SavedPost[index].post!.likesCount.obs,
                                                        textPost: controller.SavedPost[index].post!.content,
                                                        nickName: controller.SavedPost[index].post!.author!.user!.firstName!+
                                                        ' '+
                                                        controller.SavedPost[index].post!.author!.user!.lastName!,
                                                        numberOfComments: controller.SavedPost[index].post!.commentsCount
                                                            .toString()
                                                            .obs,
                                                        userImage:
                                                        controller.SavedPost[index].post!.author!.user!.profileImage,
                                                        key: ValueKey(controller.SavedPost[index].id),
                                                      )
                                                         );
                                                },
                                              )
                                            : MasonryGridView.builder(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemCount:
                                                 controller.postView.value? controller.Posts.length:controller.SavedPost.length,
                                                gridDelegate:
                                                    SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2),
                                                itemBuilder: (context, index) {
                                                  var name = controller.Posts[index].author!.user!.firstName! +
                                                      controller.Posts[index].author!.user!.lastName!;
                                                  var date = DateFormat('yyyy-mm-dd')
                                                      .parse(controller.Posts[index].createdAt!);
                                                  return AnimatedSwitcher(
                                                        duration: Duration(
                                                            milliseconds: 1000),
                                                        reverseDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    1000),
                                                        child:
                                                        !controller.postView.value
                                                                ? Post(
                                                          saveId: controller.SavedPost[index].post!.savedPostId!,
                                                          likeId: controller.SavedPost[index].post!.likeId!,
                                                          authorId: controller.SavedPost[index].post!.author!,
                                                          topics:controller.SavedPost[index].post!.topicsDetails,
                                                          id: controller.SavedPost[index].post!.id,
                                                          imageUrl: controller.SavedPost[index].post!.image,
                                                          username:
                                                          controller.SavedPost[index].post!.author!.user!.username,
                                                          date:DateFormat('yyyy-mm-dd')
                                                              .parse(controller.SavedPost[index].post!.createdAt!) ,
                                                          url: controller.SavedPost[index].post!.link,
                                                          numberOfLikes: controller.SavedPost[index].post!.likesCount.obs,
                                                          textPost: controller.SavedPost[index].post!.content,
                                                          nickName: controller.SavedPost[index].post!.author!.user!.firstName!+
                                                              ' '+
                                                              controller.SavedPost[index].post!.author!.user!.lastName!,
                                                          numberOfComments: controller.SavedPost[index].post!.commentsCount
                                                              .toString()
                                                              .obs,
                                                          userImage:
                                                          controller.SavedPost[index].post!.author!.user!.profileImage,
                                                          key: ValueKey(controller.SavedPost[index].id),
                                                        ):
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
                                                  key: ValueKey(controller.Posts[index].id
                                                            )));
                                                },
                                              ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 6,
                      right: MediaQuery.of(context).size.width * 0.30,
                      child: GestureDetector(
                        onTap: () =>
                            controller.showImage(controller.profileImage.value),
                        onLongPress: () => Get.bottomSheet(
                          controller.bottomsheet(1),
                          elevation: 10,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40))),
                          backgroundColor: Theme.of(context).backgroundColor,
                          enterBottomSheetDuration:
                              const Duration(milliseconds: 500),
                          exitBottomSheetDuration:
                              const Duration(milliseconds: 500),
                        ),
                        child: Stack(
                          children: [
                            GetX(
                              builder: (ProfileController controller) => Container(
                                height: 150,
                                width: 150,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).backgroundColor,
                                      width: 5),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          controller.profileImage.value),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 120,
                                bottom: 0,
                                child: GetX(
                                  builder: (notificationsController controller) =>
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: controller.isOnline.value==true?Colors.green:Colors.grey,
                                        ),
                                      ),
                                )),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
          } else {
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade500,
                highlightColor: Colors.grey.shade700,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 60),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 4, color: Colors.grey),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 9,
                      right: MediaQuery.of(context).size.width * 0.28,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).backgroundColor,
                              width: 5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ));
          }
        }),
      ),
    );
  }
}
