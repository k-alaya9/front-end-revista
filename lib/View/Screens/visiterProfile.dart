import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Services/apis/login_api.dart';
import 'package:shimmer/shimmer.dart';
import '../../Controllers/visitProfileController.dart';
import '../../Services/apis/chat_api.dart';
import '../Widgets/post.dart';
import '../Widgets/reportWidget.dart';

class visiterProfileScreen extends StatelessWidget {
   visiterProfileScreen({Key? key}) : super(key: key);

  visitProfileController controller = Get.put(visitProfileController());
  @override
  Widget build(BuildContext context) {
    visitProfileController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: Material(
            color: Theme.of(context).backgroundColor,
            child: IconButton(onPressed: (){
              Get.back();
            }, icon: Icon(Icons.arrow_back_ios)),
          ),
          middle: Container(alignment: Alignment(2,0),child: Text(controller.Username!.value,style: Theme.of(context).textTheme.headline1,overflow: TextOverflow.visible,)),
          trailing: Material(
            color: Theme.of(context).backgroundColor,
            child: DropdownButton(
                icon: Icon(Icons.more_vert),
                underline: Container(),
                items: [
                  DropdownMenuItem(child: Row(children: [
                    Icon(Icons.report_problem_outlined,color: Colors.red,),
                    SizedBox(width: 5,),
                    Text('Report User'),
                  ],),value: 1,),
                  DropdownMenuItem(child: Row(children: [
                    Icon(Icons.block_outlined,color: Colors.red,),
                    SizedBox(width: 5,),
                    Text('Block User'),
                  ],),value: 2,),
                ], onChanged: (val){
              if(val==1){
                Get.defaultDialog(
                  content: Report(type: 'user',id: controller.id.value),
                  title: 'Report',
                  contentPadding: EdgeInsets.zero,
                );
              }
            }),
          ),
        ),
        extendBody: true,
        body:
        Obx((){
          if(controller.profileImage!.value.isNotEmpty) {
            return SmartRefresher(
              header: ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
              onRefresh: controller.onRefresh,
              enablePullUp: false,
              enablePullDown: true,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 60,left:15),
                                      alignment: Alignment.center,
                                      child: Text(
                                        controller.firstname!.value+" "+controller.lastName!.value,
                                        style:
                                        Theme.of(context).textTheme.headline1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                            textAlign: TextAlign.center,
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
                                    textAlign: TextAlign.center,
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
                                      // decoration: BoxDecoration(
                                      //     color:Colors.grey[300],
                                      //     shape: BoxShape.rectangle,
                                      //     borderRadius: BorderRadius.circular(20)),
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
                                        // decoration: BoxDecoration(
                                        //     color: Colors.grey[300],
                                        //     shape: BoxShape.rectangle,
                                        //     borderRadius: BorderRadius.circular(20)),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Posts',
                                              style:Theme.of(context)
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
                                      // decoration: BoxDecoration(
                                      //     color:Colors.grey[300],
                                      //     shape: BoxShape.rectangle,
                                      //     borderRadius: BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Following",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
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
                                                      : Theme.of(context).accentColor,
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
                                                      : Theme.of(context).accentColor,
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
                                          var name = controller.Posts[index].author!.user!.firstName! +
                                              controller.Posts[index].author!.user!.lastName!;
                                          var date = DateFormat('yyyy-mm-dd')
                                              .parse(controller.Posts[index].createdAt!);
                                          return  AnimatedSwitcher(duration: Duration(milliseconds: 1000),
                                            reverseDuration: Duration(milliseconds: 1000),child:
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
                                            )
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
                                        itemBuilder: (context, index) {
                                          var name = controller.Posts[index].author!.user!.firstName! +
                                              controller.Posts[index].author!.user!.lastName!;
                                          var date = DateFormat('yyyy-mm-dd')
                                              .parse(controller.Posts[index].createdAt!);
                                          return AnimatedSwitcher(duration: Duration(milliseconds: 1000),
                                              reverseDuration: Duration(milliseconds: 1000),child:
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
                                                )
                                                   // Post(),
                                                  );
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
                    Positioned(
                      top: MediaQuery.of(context).size.height / 6,
                      right: MediaQuery.of(context).size.width * 0.29,
                      child: GestureDetector(
                        onTap:()=>controller.showImage(controller.profileImage!.value),
                        child: Container(
                          height: 150,
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
