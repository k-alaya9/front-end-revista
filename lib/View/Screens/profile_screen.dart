import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../Controllers/ProfileController.dart';
import '../Widgets/post.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        body: Obx((){
      if(controller.profileImage.value.isNotEmpty&&controller.CoverImage.value.isNotEmpty) {
        return SmartRefresher(
          onLoading: null,
          header: ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
          footer: null,
          onRefresh: controller.onRefresh,
          enablePullUp: true,
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
                        onTap: () =>
                            controller.showImage(controller.CoverImage.value),
                        onLongPress: () => Get.bottomSheet(
                          controller.bottomsheet(2),
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
                        child: GetX(
                          builder: (ProfileController controller) => Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image:
                                  NetworkImage(controller.CoverImage.value),
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
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 60),
                                    child: Text(
                                      controller.firstname.value +
                                          controller.lastName.value,
                                      style:
                                      Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            color:
                                            Theme.of(context).primaryColor,
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                          icon: Icon(Icons.edit,
                                              size: 20, color: Colors.white),
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
                                  style: Theme.of(context).textTheme.bodyText1,
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
                                      decoration: BoxDecoration(
                                          color:
                                          Theme.of(context).backgroundColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Followers',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            controller.followers.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashFactory: NoSplash.splashFactory,
                                    onTap: () {
                                      Scrollable.ensureVisible(
                                          controller.ListKey.currentContext!,
                                          duration: Duration(seconds: 1));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color:
                                          Theme.of(context).backgroundColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Posts',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            controller.numberOfPosts.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
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
                                      decoration: BoxDecoration(
                                          color:
                                          Theme.of(context).backgroundColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Following",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            controller.following.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
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
                                            color:
                                            Theme.of(context).primaryColor,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: controller.postView.value
                                                ? Border(
                                                bottom: BorderSide(
                                                    width: 4,
                                                    color: Theme.of(context)
                                                        .primaryColor))
                                                : null),
                                        child: TextButton(
                                          style: ButtonStyle(
                                              splashFactory:
                                              NoSplash.splashFactory),
                                          onPressed: () =>
                                              controller.switchViewPost(),
                                          child: Text('Posts',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                  color: controller
                                                      .postView.value
                                                      ? Theme.of(context)
                                                      .primaryColor
                                                      : Colors.deepPurple[
                                                  100])),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: !controller.postView.value
                                                ? Border(
                                                bottom: BorderSide(
                                                    width: 4,
                                                    color: Theme.of(context)
                                                        .primaryColor))
                                                : null),
                                        child: TextButton(
                                          style: ButtonStyle(
                                              splashFactory:
                                              NoSplash.splashFactory),
                                          onPressed: () =>
                                              controller.switchViewSavedPosts(),
                                          child: Text('Saved',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                  color: !controller
                                                      .postView.value
                                                      ? Theme.of(context)
                                                      .primaryColor
                                                      : Colors.deepPurple[
                                                  100])),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: IconButton(
                                              onPressed: () => controller
                                                  .switchViewVertical(),
                                              icon: Icon(
                                                Icons.vertical_split_outlined,
                                                color: controller.View.value
                                                    ? Theme.of(context)
                                                    .primaryColor
                                                    : Colors.deepPurple[100],
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: IconButton(
                                              onPressed: () => controller
                                                  .switchViewHorizontal(),
                                              icon: Icon(
                                                Icons.horizontal_split_outlined,
                                                color: !controller.View.value
                                                    ? Theme.of(context)
                                                    .primaryColor
                                                    : Colors.deepPurple[100],
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 1000),
                                    reverseDuration: Duration(milliseconds: 1000),
                                    transitionBuilder: (child,animation){
                                      return SlideTransition(
                                        position: animation.drive(Tween(begin: Offset(1.0, 0.0),end: Offset(0, 0))),
                                        child: child,
                                      );
                                    },
                                    child: controller.View.value
                                        ? ListView.builder(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.Posts.length,
                                      itemBuilder: (ctx, index) {
                                        return  AnimatedSwitcher(duration: Duration(milliseconds: 1000),
                                          reverseDuration: Duration(milliseconds: 1000),child:
                                            //controller.postView.value
                                              // ? Post()
                                            //  : SavedPost(),
                                            Container()
                                        );
                                      },
                                    )
                                        : MasonryGridView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: controller.Posts.length,
                                      gridDelegate:
                                      SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                      itemBuilder: (context, index) =>
                                          AnimatedSwitcher(duration: Duration(milliseconds: 1000),
                                            reverseDuration: Duration(milliseconds: 1000),child:
                                            // controller.postView.value
                                            //     ? Container()
                                            //     : SavedPost(),
                                            //
                                            Container()
                                          ),
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
                  top: MediaQuery.of(context).size.height / 9,
                  right: MediaQuery.of(context).size.width * 0.28,
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
                    child: GetX(
                      builder: (ProfileController controller) => Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).backgroundColor,
                              width: 5),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                              NetworkImage(controller.profileImage.value),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      else {
        return
          Shimmer.fromColors(
              baseColor: Colors.grey.shade500,
              highlightColor: Colors.grey.shade700,
              child:Stack(
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
                      Divider(thickness: 1,),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20)),
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
                      Divider(thickness: 4,color: Colors.grey),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 9,
                    right: MediaQuery.of(context).size.width * 0.28,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).backgroundColor,width: 5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              )
          );
      }
    }
      ),),
    );
  }
}
