import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Services/apis/login_api.dart';
import 'package:shimmer/shimmer.dart';
import '../../Controllers/visitProfileController.dart';
import '../../Services/apis/chat_api.dart';
import '../Widgets/post.dart';

class visiterProfileScreen extends StatelessWidget {
   visiterProfileScreen({Key? key}) : super(key: key);

  visitProfileController controller = Get.put(visitProfileController());
  @override
  Widget build(BuildContext context) {
    visitProfileController controller = Get.find();
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
        extendBody: true,
        body:
        Obx((){
          if(controller.profileImage!.value.isNotEmpty) {
            return SmartRefresher(
              header: ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
              onRefresh: controller.onRefresh,
              enablePullUp: true,
              enablePullDown: false,
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
                                          onPressed: ()async{
                                            var token= await getAccessToken();
                                            var chatId=await newChat(token,controller.id.value);
                                          },
                                          child: Text('Message'),
                                          style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15),
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
                                            child: Text(controller.followId.value !=0 ?'following':'follow'),
                                            style: ButtonStyle(
                                              shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15),
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
                                          color:Colors.grey[300],
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Followers',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!.copyWith(color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            controller.followers!.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!.copyWith(color: Colors.black),
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
                                            color: Colors.grey[300],
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Posts',
                                              style:Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!.copyWith(color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              controller.numberOfPosts!.value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!.copyWith(color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color:Colors.grey[300],
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Following",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!.copyWith(color: Colors.black
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            controller.following!.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!.copyWith(color: Colors.black),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: MediaQuery.of(context).size.width/4,),
                                        Container(
                                          decoration: BoxDecoration(
                                              border:Border(
                                                  bottom: BorderSide(
                                                      width: 4,
                                                      color: Theme.of(context)
                                                          .primaryColor))
                                                  ),
                                          child: Text('Posts',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                     )),
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
                                            Container()
                                                 // Post()
                                                ,);
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
                                                Container()
                                                   // Post(),
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
                                fit: BoxFit.cover),
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
        ),
      ),
    );
  }
}
