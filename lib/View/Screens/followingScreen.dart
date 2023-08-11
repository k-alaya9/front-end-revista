import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../Controllers/followingController.dart';
import '../Widgets/followerLIst.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
class FollowingScreen extends StatelessWidget {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    followingController controller = Get.put(followingController());
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: Material(
          color: Theme.of(context).backgroundColor,
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        middle: GetX(
          builder: (followingController controller) => AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: animation.drive(
                    Tween(begin: Offset(1.0, 0.0), end: Offset(0, 0))),
                child: child,
              );
            },
            child: controller.isSearching.value?CupertinoTextField(
              placeholder: 'Search here...',
            ): Text('Followings',style: Theme.of(context).textTheme.headline1,),
          ),),
        trailing: Material(
            color: Theme.of(context).backgroundColor,
            child: IconButton(
                onPressed: controller.switchSearch, icon: Icon(Icons.search))),
      ),
      body: FutureBuilder(
          future: controller.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey.shade500,
                  highlightColor: Colors.grey.shade700,
                  enabled: true,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.13,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black12, width: 0.2)),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            style: ListTileStyle.drawer,
                            leading: Container(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey.shade900,
                              ),
                            ),
                            title: Container(
                                width: 100,
                                height: 5,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    shape: BoxShape.rectangle)),
                            subtitle: Container(
                                width: 150,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    shape: BoxShape.rectangle)),
                            trailing: Container(
                                width: 20,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    shape: BoxShape.rectangle)),
                          ),
                        ),
                      ),
                    ),
                  ));
            }
            return SmartRefresher(
              header:
                  ClassicHeader(refreshingIcon: CupertinoActivityIndicator(),),
              onRefresh: controller.onRefresh,
              enablePullDown: true,
              enablePullUp: true,
              controller: controller.refreshController,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: controller.followings.length,
                itemBuilder: (context, index) =>  AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1400),
                  child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(
                      duration: const Duration(seconds: 1),
                      child: followerList(
                        id: controller.followings[index].followed!.id,
                        followId: controller.followings[index].id!,
                        name: controller.followings[index].followed!.user!.firstName,
                        lastname: controller.followings[index].followed!.user!.lastName==null?'':controller.followings[index].followed!.user!.lastName,
                        username: controller.followings[index].followed!.user!.username,
                        imageUrl: controller.followings[index].followed!.user!.profileImage,

                      ),
                    ),
                  ),
                ),
                ),

            );
          }),
    );
  }
}
