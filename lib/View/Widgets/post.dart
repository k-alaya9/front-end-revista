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
import 'package:revista/Services/apis/login_api.dart';
import 'package:revista/View/Widgets/showImage.dart';
import 'package:revista/View/Widgets/topicPost.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Controllers/postController.dart';
import '../../Models/topic.dart';
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
  final List<topicItem>topics;
  final authorId;
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
        required this.textPost, this.userImage,required this.id,required this.topics});

  @override
  Widget build(BuildContext context) {
    viewPostController controller = Get.find();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              shape: BoxShape.rectangle,
              border: Border.symmetric(horizontal: BorderSide())),
          child: Column(children: [
            InkWell(
              onTap: (){
                Get.toNamed('/visitProfile', arguments: {
                  'id': authorId,
                });
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(userImage,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text: '${nickName} \n',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              TextSpan(
                                  text: username,
                                  style: TextStyle(color: Colors.grey)),
                            ]),
                          ),
                          PopupMenuButton(
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  child: Text('Copy Link'),
                                  value: 1,
                                  onTap: (){},
                                ),
                                PopupMenuItem(
                                  child: Text('Delete Post'),
                                  value: 2,
                                  onTap: (){},
                                ),
                                PopupMenuItem(
                                  child: Text('Report Post'),
                                  value: 3,
                                  onTap: (){},

                                ),
                              ];
                            },
                            icon: Icon(Icons.more_vert),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                            //  padding: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width - 20,
                              child: ListView.builder(
                                  itemCount: topics.length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    print(topics);
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        child: TopicWidget(id: topics[index].id,name: topics[index].name,pressed: false.obs,)
                                      );}),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.all(0),
                child: Column(
                  children: [
                    ReadMoreText(
                     textPost,
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
                      style: TextStyle(
                        fontSize: 16,
                        height: 2,
                      ),
                    ),
                    imageUrl == null
                        ? Container()
                        : InkWell(
                            onTap: () {
                              Get.to(() => ShowImage(imageUrl: imageUrl,));
                            },
                            child: Container(
                              child: CachedNetworkImage(
                                  fit: BoxFit.fitWidth,
                                  placeholder: (context, url) =>
                                      Image.asset('asset/image/loading.png'),
                                  imageUrl:imageUrl!),
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
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Transform.translate(
                  offset: Offset(-10, 0),
                  child: Text(
                    controller.format(date),
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  )),
            ),
            Divider(
              color: Colors.black54,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(
                  likeCount: numberOfLikes.value,
                   onTap: (like)async{
                     like=!like;
                     var token=getAccessToken();
                     if(like){
                       await likePost(token,id);
                     }else{
                       await unlikePost(token, id);
                     }
                   },
                  likeBuilder: (isTapped) {
                    return Icon(
                      Icons.favorite,
                      color: isTapped ? Colors.deepPurple : Colors.grey,
                      size: 30,
                    );
                  },
                ),
                Row(
                  children: [
                    InkWell(

                      onTap: () {
                        Get.to(ViewPost(),arguments: {
                          'postId':id
                        });
                      },
                      child: Icon(
                        Icons.speaker_notes_outlined,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                    Text(
                      numberOfComments.value,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                InkWell(
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
                LikeButton(
                  onTap: (save)async{
                    save=!save;
                    var token=getAccessToken();
                    if(save){
                      await savePost(token,id);
                    }else{
                      await unSavedPost(token, id);
                    }
                  },
                  likeBuilder: (isTapped) {
                    return Icon(
                      Icons.bookmark,
                      color: isTapped ? Colors.deepPurple : Colors.grey,
                      size: 30,
                    );
                  },
                ),
              ],
            ),
          ])),
    );
  }
}
