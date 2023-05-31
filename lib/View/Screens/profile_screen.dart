import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Controllers/ProfileController.dart';
import '../Widgets/post.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController controller=Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        body: SmartRefresher(
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
                Column(
                  children: [
                    GestureDetector(
                      onTap: ()=>controller.showImage(controller.CoverImage),
                      onLongPress: ()=>Get.bottomSheet(controller.bottomsheet(2),elevation: 10,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40))),
                        backgroundColor: Theme.of(context).backgroundColor,
                        enterBottomSheetDuration: const  Duration(milliseconds: 500),
                        exitBottomSheetDuration: const Duration(milliseconds: 500),),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(controller.CoverImage),
                              fit: BoxFit.cover),
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
                                    controller.firstname+controller.lastName,
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
                                        controller.Username,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Container(
                                      width: 33,
                                      decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                                          shape: BoxShape.circle
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.edit,size: 20,color: Colors.white),
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
                                controller.bio,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  onTap:(){
                                    Get.toNamed('/followers');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).backgroundColor,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20)),
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
                                          controller.followers,
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
                                  onTap: (){
                                    Scrollable.ensureVisible(controller.ListKey.currentContext!,duration: Duration(seconds: 1));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).backgroundColor,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20)),
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
                                          controller.numberOfPosts,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        splashFactory: NoSplash.splashFactory,
                                        onTap: (){
                                          Get.toNamed('/following');
                                        },

                                        child: Text(
                                          "Following",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        controller.following,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ],
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
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(width: 4))
                                  ),
                                  child: Text('Posts',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1),
                                ),
                                SizedBox(height: 10,),
                                ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.Posts.length,
                                  itemBuilder: (ctx, index) {
                                    return Post();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 9,
                  right: MediaQuery.of(context).size.width * 0.28,
                  child: GestureDetector(
                    onTap:()=>controller.showImage(controller.profileImage),
                    onLongPress: ()=>Get.bottomSheet(controller.bottomsheet(1),
                      elevation: 10,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40))),
                      backgroundColor: Theme.of(context).backgroundColor,
                      enterBottomSheetDuration: const  Duration(milliseconds: 500),
                      exitBottomSheetDuration: const Duration(milliseconds: 500),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).backgroundColor,width: 5),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(controller.profileImage),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
