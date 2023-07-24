// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:readmore/readmore.dart';
// import 'package:intl/intl.dart';
// import 'package:like_button/like_button.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:revista/Controllers/ProfileController.dart';
// import 'package:revista/View/Widgets/showImage.dart';
// import 'package:url_launcher/url_launcher.dart';
// String? imageUrl='https://media.istockphoto.com/id/1263601084/vector/soccer-ball-symbol-football-ball-icon.jpg?s=612x612&w=0&k=20&c=2Y9kyn2vhU2luJtcj10IGySX4jtf41r_AraQxTT-5yM=';
// class Post extends StatefulWidget {
//   @override
//   State<Post> createState() => _PostState();
// }
//
// class _PostState extends State<Post> {
//   var nickName = 'data Base';
//
//   var userName = 'ghazal Alnasr';
//
//   var post =
//       'ضروريبدي نصيحة عن تجربةانصحوني ب معهد منيح للغة الإنكليزية اقدر اوصل معو للنطق الصحيح ودرجة الاتقان متل العربية ب الشامواسم سلسلة جيدة للدراسة';
//
//   DateTime date = DateTime.now();
//
//   var numberOfLikes = 122;
//
//   var numberOfComments = '122';
//
//   String? url='https://poe.com/ChatGPT' ;
//
//   format(ddate) {
//     DateFormat newDate = DateFormat.yMd().add_jms();
//     String time = newDate.format(ddate);
//     return time;
//   }
//   ProfileController controller=Get.find();
//   @override
//   Widget build(BuildContext context) {
//     List Comments=List.generate(5, (index) => null);
//     return  Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20)
//       ),
//       elevation: 2,
//       child: Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Theme.of(context).backgroundColor,
//             borderRadius: BorderRadius.circular(20),
//             shape: BoxShape.rectangle,
//           ),
//           child: Column(
//             //mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundColor: Colors.blue,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Column(
//                       children: [
//                         RichText(
//                           textAlign: TextAlign.start,
//                           text: TextSpan(children: [
//                             TextSpan(
//                               text: '$nickName \n',
//                               style: Theme.of(context).textTheme.bodyText1,
//                             ),
//                             TextSpan(
//                                 text: userName,
//                                 style: TextStyle(color: Colors.grey)),
//                           ]),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 SingleChildScrollView(
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     margin: EdgeInsets.all(0),
//                     child: Column(
//                       children: [
//                         ReadMoreText(
//                           post,
//                           trimLines: 3,
//                           textAlign: TextAlign.justify,
//                           trimMode: TrimMode.Line,
//                           trimCollapsedText: 'Show More',
//                           trimExpandedText: 'show less',
//                           lessStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey,
//                             decoration: TextDecoration.underline,
//                           ),
//                           moreStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey,
//                             decoration: TextDecoration.underline,
//                           ),
//                           style: TextStyle(
//                             fontSize: 16,
//                             height: 2,
//                           ),
//                         ),
//                         imageUrl == null
//                             ? Container()
//                             : InkWell(
//                           onTap: (){
//                             Get.to(()=>ShowImage());
//                           },
//                           child: Container(
//                             child: CachedNetworkImage(
//                                 fit: BoxFit.fitWidth,
//                                 placeholder: (context, url) =>
//                                     Image.asset('asset/image/loading.png'),
//                                 imageUrl: imageUrl!),
//                           ),
//                         ),
//                         url==null?
//                         Container():
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           child: TextButton(
//                             onPressed: () async{
//                               await launchUrl(Uri.parse(url!),mode: LaunchMode.externalApplication);
//                             },
//                             child: Text(url!, style: TextStyle(
//                                 decoration: TextDecoration.underline),),
//
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Transform.translate(
//                   offset: Offset(0, 0),
//                   child: Container(
//                     alignment: Alignment.bottomRight,
//                     child: Transform.translate(
//                         offset: Offset(-10, 0),
//                         child: Text(
//                           format(date),
//                           style:
//                           TextStyle(color: Colors.black54, fontSize: 12),
//                         )),
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.black54,
//                   thickness: 1,
//                   indent: 10,
//                   endIndent: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     LikeButton(
//                       likeCount:controller.View.value? numberOfLikes:null,
//                       likeBuilder: (isTapped) {
//                         return Icon(
//                           Icons.favorite,
//                           color: isTapped ? Colors.deepPurple : Colors.grey,
//                           size: 30,
//                         );
//                       },
//                     ),
//                     Row(
//                       children: [
//                         InkWell(
//                           onTap: (){
//                             Get.bottomSheet(
//                               Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Container(
//                                     child: ListView.builder(
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.vertical,
//                                       itemCount: Comments.length,
//                                       itemBuilder: (ctx, index) {
//                                         return CommentScreen();
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               elevation: 10,
//                               isScrollControlled: true,
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(40),
//                                       topLeft: Radius.circular(40))),
//                               backgroundColor: Theme.of(context).backgroundColor,
//                               enterBottomSheetDuration: const Duration(seconds: 1),
//                               exitBottomSheetDuration: const Duration(seconds: 1),
//                             );
//                           },
//                           child: Icon(
//                             Icons.speaker_notes_outlined,
//                             color: Colors.grey,
//                             size: 30,
//                           ),
//                         ),
//                         controller.View.value?
//                         Text(
//                           numberOfComments,
//                           style: TextStyle(
//                             color: Colors.grey,
//                           ),
//                         ):Container(),
//                       ],
//                     ),
//                     InkWell(
//
//                       child: Container(
//                         height: 28,
//                         width: 28,
//                         child: SvgPicture.asset(
//                           'asset/image/instagram-share-icon.svg',
//                           color: Colors.grey,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     LikeButton(
//                       likeBuilder: (isTapped) {
//                         return Icon(
//                           Icons.bookmark,
//                           color: isTapped ? Colors.deepPurple : Colors.grey,
//                           size: 30,
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ])),
//     );
//   }
// }

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
import 'package:revista/View/Widgets/showImage.dart';
import 'package:revista/View/Widgets/topicPost.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Controllers/postController.dart';
import '../Screens/ViewPost.dart';

class Post extends StatelessWidget {
  var x = Get.put(viewPostController());
  viewPostController controller = Get.find();
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
  final List topics;
  Post(
      {super.key,
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              shape: BoxShape.rectangle,
              border: Border.symmetric(horizontal: BorderSide())),
          child: Column(children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(userImage,),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
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
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 20,
                      child: ListView.builder(
                          itemCount: topics.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 5),
                                child: TopicWidget(
                                    id: topics[index].id,
                                    name: topics[index].name,
                                    pressed: false.obs),
                              )),
                    ),
                  ],
                ),
              ],
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
            Transform.translate(
              offset: Offset(0, 0),
              child: Container(
                alignment: Alignment.bottomRight,
                child: Transform.translate(
                    offset: Offset(-10, 0),
                    child: Text(
                      controller.format(date),
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    )),
              ),
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
