import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Controllers/visitProfileController.dart';
import '../Widgets/post.dart';

class visiterProfileScreen extends StatelessWidget {
  const visiterProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    visitProfileController controller = Get.put(visitProfileController());
    return SafeArea(
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          leading: Material(
            color: Theme.of(context).backgroundColor,
            child: IconButton(onPressed: (){
              Get.back();
            }, icon: Icon(Icons.arrow_back_ios)),
          ),
          trailing: Material(color: Theme.of(context).backgroundColor,
              child: IconButton(onPressed:(){}, icon: Icon(Icons.more_vert))
          ),
        ),
        body:SmartRefresher(
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
                      onTap: ()=>controller.showImage(controller.CoverImage!.value),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(controller.CoverImage!.value),
                              fit: BoxFit.fitWidth),
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
                                    controller.firstname!.value+controller.lastName!.value,
                                    style:
                                    Theme.of(context).textTheme.headline1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                      },
                                      child: Text('Message'),
                                      style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        elevation: MaterialStatePropertyAll(0),
                                        backgroundColor:
                                        MaterialStatePropertyAll(Theme.of(context).primaryColor),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        controller.Username!.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    GetX(
                                      builder: (visitProfileController controller)=> ElevatedButton(
                                        onPressed: controller.follow,
                                        child: Text(controller.isFollowing.value?'unfollow':'follow'),
                                        style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          elevation: MaterialStatePropertyAll(0),
                                          backgroundColor:
                                          MaterialStatePropertyAll(Theme.of(context).primaryColor),
                                        ),
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
                                controller.bio!.value,
                                style: Theme.of(context).textTheme.bodyText1,
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
                                        controller.followers!.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ],
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
                                          controller.numberOfPosts!.value,
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
                                        controller.following!.value,
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
                    onTap:()=>controller.showImage(controller.profileImage!.value),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).backgroundColor,width: 5),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(controller.profileImage!.value),
                            fit: BoxFit.fitWidth),
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
