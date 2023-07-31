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
import 'package:revista/main.dart';
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
    var id;
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            shape: BoxShape.rectangle,
            ),
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
                    SizedBox(
                      height: 5,
                    ),
                    // Container(
                    //   height: 40,
                    //   width: MediaQuery.of(context).size.width - 20,
                    //   child: ListView.builder(
                    //       itemCount: topics.length,
                    //       shrinkWrap: true,
                    //       physics: ScrollPhysics(),
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (context, index) {
                    //         print(topics);
                    //         return Padding(
                    //             padding: EdgeInsets.symmetric(
                    //                 horizontal: 5, vertical: 10),
                    //             child: TopicWidget(id: topics[index].id,name: topics[index].name,pressed: false.obs,)
                    //           );}),
                    // ),
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
              margin:EdgeInsets.only(left: 55),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: Theme.of(context).textTheme.bodyText1
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
          SizedBox(height: 10,),
          Transform.translate(
            offset: Offset(0, 0),
            child: Container(
              alignment: Alignment.bottomRight,
              child: Transform.translate(
                  offset: Offset(-10, 0),
                  child: Text(
                    controller.format(date),
                    style: TextStyle(color:Get.isDarkMode?Colors.white:Colors.black, fontSize: 12),
                  )),
            ),
          ),
          Divider(
            color: Get.isDarkMode?Colors.white:Colors.black54,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder(
                builder: (viewPostController controller) => LikeButton(
                  likeCount: numberOfLikes.value,
                  onTap: (like)async{
                    like!=like;
                    var token=sharedPreferences!.getString('access_token');

                    if(!like){
                      like =(id=await likePost(token,this.id))!=null?true:false;
                      print(id);
                    }else{
                      print(id);
                    like = await unlikePost(token, id);
                    }
                    return like;
                  },
                  likeBuilder: (isTapped) {
                    return Icon(
                      Icons.favorite,
                      color: isTapped ? Theme.of(context).primaryColor : Colors.grey,
                      size: 30,
                    );
                  },
                ),

              ),
              Row(
                children: [
                  InkWell(

                    onTap: () {
                      Get.to(ViewPost());
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
                likeBuilder: (isTapped) {
                  return Icon(
                    Icons.bookmark,
                    color: isTapped ? Theme.of(context).primaryColor : Colors.grey,
                    size: 30,
                  );
                },
              ),
            ],
          ),
        ]));
  }
}
