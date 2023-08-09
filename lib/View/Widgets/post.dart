import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revista/Controllers/ProfileController.dart';
import 'package:revista/Services/apis/login_api.dart';
import 'package:revista/View/Widgets/showImage.dart';
import 'package:revista/View/Widgets/topicPost.dart';
import 'package:revista/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Controllers/postController.dart';
import '../../Models/topic.dart';
import '../../Services/apis/chat_api.dart';
import '../../Services/apis/post_api.dart';
import '../Screens/ViewPost.dart';

class Post extends StatelessWidget {
  final id;
  final imageUrl;
  final username;
  final date;
  final nickName;
  final numberOfLikes;
  final numberOfComments;
  final url;
  final textPost;
  final userImage;
  final topics;
  final authorId;
  var likeId;
  var saveId;

  Post(
      {super.key,
      required this.authorId,
      required this.imageUrl,
      required this.username,
      required this.date,
      required this.nickName,
      required this.numberOfLikes,
      required this.numberOfComments,
      required this.url,
      required this.textPost,
      this.userImage,
      required this.id,
      required this.topics,
      this.likeId,
      this.saveId});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController=Get.find();
    viewPostController controller = Get.find();
    var id;
    print(saveId);
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        shape: BoxShape.rectangle,
      ),
      child: Column(children: [
        InkWell(
          onTap: () {
            print(authorId);
            Get.toNamed('/visitProfile', arguments: {
              'id': authorId,
            });
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  userImage,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      TextSpan(
                        text: '${nickName} \n',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      TextSpan(
                          text: username, style: TextStyle(color: Colors.grey)),
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 40,
                    child: ListView.builder(
                        itemCount: topics.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).accentColor,
                              ),
                              child: Center(
                                child: Text(topics[index]!['name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1),
                              ));
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(left: 55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReadMoreText(textPost,
                    trimLines: 3,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show More',
                    trimExpandedText: 'show less',
                    lessStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                    moreStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                    style: Theme.of(context).textTheme.bodyText1),
                imageUrl == null
                    ? Container()
                    : InkWell(
                        onTap: () {
                          Get.to(() => ShowImage(
                                imageUrl: imageUrl,
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                placeholder: (context, url) =>
                                    Image.asset('asset/image/loading.png'),
                                imageUrl: imageUrl!),
                          ),
                        ),
                      ),
                url == null
                    ? Container()
                    : Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () async {
                            await launchUrl(Uri.parse(url!),
                                mode: LaunchMode.externalApplication);
                          },
                          child: Text(
                            url!,
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, 0),
          child: Container(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
                offset: Offset(-10, 0),
                child: Text(
                  controller.format(date),
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 12),
                )),
          ),
        ),
        Divider(
          color: Get.isDarkMode ? Colors.white : Colors.black54,
          thickness: 1,
          indent: profileController.View.value?70:10,
          endIndent: 10,
        ),
        Container(
          margin: EdgeInsets.only(left:profileController.View.value? 60:0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GetBuilder(
                builder: (viewPostController controller) => LikeButton(
                  likeCount: numberOfLikes.value,
                  isLiked: likeId != 0 ? true : false,
                  onTap: (like) async {
                    print(likeId);
                    var token = sharedPreferences!.getString('access_token');
                    if (!like && likeId == 0) {
                      like = (likeId = await likePost(token, this.id)) != null
                          ? true
                          : false;
                      print(likeId);
                    } else if (like && likeId != 0) {
                      print(likeId);
                      like = await unlikePost(token, likeId);
                      likeId = 0;
                    }
                    // like=!like;
                    return like;
                  },
                  likeBuilder: (isTapped) {
                    return isTapped
                        ? Icon(
                            Icons.favorite,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.grey,
                            size: 30,
                          );
                  },
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(ViewPost(), arguments: {'postId': this.id});
                    },
                    child: Icon(
                      Icons.mode_comment_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    numberOfComments.value,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () async{
                  var token = sharedPreferences!.getString('access_token');
                  try {
                    final data;
                    data = await getChats(token);
                    controller.chats.assignAll(data);
                  } catch (e) {
                    print(e);
                  }
                  Get.bottomSheet(
                    Container(
                      height: MediaQuery.of(context).size.height/2,
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(25),
                                color:
                                    Get.isDarkMode ? Colors.white : Colors.black),
                          ),
                          Text('Share',
                              style: Theme.of(context).textTheme.headline1),
                          Expanded(
                            child: Scaffold(
                              body: Column(children: [ListView.builder(
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: controller.chats.length,
                                  itemBuilder: (context, index) {
                                    var selected = false.obs;
                                    if (controller.chats.isNotEmpty) {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        height:
                                        MediaQuery.of(context).size.height * 0.13,
                                        child: ListTile(
                                          onTap: () {
                                            selected.value = !selected.value;
                                            if(selected.value)
                                            controller.selectedChats.add(controller.chats[index].id);
                                            if(!selected.value)
                                              controller.selectedChats.remove(controller.chats[index].id);
                                            print(controller.picked.value);
                                            controller.picked.value=controller.selectedChats.isNotEmpty;
                                          },
                                          style: ListTileStyle.list,
                                          leading: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(controller
                                                      .chats[index]
                                                      .user!
                                                      .profileImage!)),
                                            ),
                                            margin: EdgeInsets.all(5),
                                          ),
                                          title: Text(
                                            controller.chats[index].user!.username!,
                                            style:
                                            Theme.of(context).textTheme.bodyText1,
                                          ),
                                          subtitle: Text(
                                            controller.chats[index].user!.firstName! +
                                                ' ' +
                                                controller.chats[index].user!.lastName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                overflow: TextOverflow.fade,
                                                color:
                                                Colors.grey.withOpacity(0.5)),
                                          ),
                                          trailing: GetX(builder: (viewPostController controller)=> Container(
                                            margin:
                                            EdgeInsets.only(top: 10, bottom: 0,right: 10),
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: selected.value
                                                    ? Theme.of(context).primaryColor
                                                    : Theme.of(context)
                                                    .backgroundColor,
                                                shape: BoxShape.circle,
                                                border: selected.value
                                                    ? null
                                                    : Border.all()),

                                          ),

                                          ),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: Text('You Dont have any chat yet'),
                                      );
                                    }
                                  }),],),
                              persistentFooterButtons: [
                                GetX(
                                    builder: (viewPostController
                                    controller) =>
                                        AnimatedSwitcher(
                                          duration: Duration(milliseconds: 500),
                                          child: controller.picked.value
                                              ? InkWell(
                                            onTap: () => controller.send(),
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                key: ValueKey(1),
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                                child: Text(
                                                  'Send',
                                                  style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                              : Container(
                                            key: ValueKey(0),
                                          ),
                                        )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),),
                    backgroundColor: Theme.of(context).backgroundColor,
                    enableDrag: true,
                    enterBottomSheetDuration: Duration(milliseconds: 500),
                    exitBottomSheetDuration: Duration(milliseconds: 500),
                  );
                },
                child: Container(
                  height: 28,
                  width: 28,
                  child: SvgPicture.asset(
                    'asset/image/instagram-share-icon.svg',
                    color: Colors.grey,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              GetBuilder(
                builder: (viewPostController controller)=>LikeButton(
                  isLiked: saveId==0?false:true,
                  onTap: (save) async {
                    print(saveId);
                    var token = sharedPreferences!.getString('access_token');
                    if (!save && saveId==0) {
                      save = (saveId = await savePost(token, this.id)) != null
                          ? true
                          : false;
                    } else if (saveId != 0) {
                      save = await unSavedPost(token, saveId);
                      saveId = 0;
                    }
                    return save;
                  },
                  likeBuilder: (isTapped) {
                    return !isTapped
                        ? Icon(
                      Icons.bookmark_border_outlined,
                      color: Colors.grey,
                      size: 30,
                    )
                        : Icon(
                      Icons.bookmark,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
