import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revista/Controllers/ProfileController.dart';
import 'package:revista/View/Widgets/showImage.dart';
import 'package:url_launcher/url_launcher.dart';
class SavedPost extends StatefulWidget {
  @override
  State<SavedPost> createState() => _SavedPostState();
}

class _SavedPostState extends State<SavedPost> {
  var nickName = 'k.alaya9';
  String? imageUrl;

  var userName = 'khaled alaya';

  var post ='hello everyone this a test text for saved post';

  DateTime date = DateTime.now();

  var numberOfLikes = 122;

  var numberOfComments = '122';

  String? url ;

  format(ddate) {
    DateFormat newDate = DateFormat.yMd().add_jms();
    String time = newDate.format(ddate);
    return time;
  }
  ProfileController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    List Comments=List.generate(5, (index) => null);
    return  Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      elevation: 2,
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
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
                              text: '$nickName \n',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            TextSpan(
                                text: userName,
                                style: TextStyle(color: Colors.grey)),
                          ]),
                        )
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
                          post,
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
                          onTap: (){
                            Get.to(()=>ShowImage());
                          },
                          child: Container(
                            child: CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                placeholder: (context, url) =>
                                    Image.asset('asset/image/loading.png'),
                                imageUrl: imageUrl!),
                          ),
                        ),
                        url==null?
                        Container():
                        Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () async{
                              await launchUrl(Uri.parse(url!),mode: LaunchMode.externalApplication);
                            },
                            child: Text(url!, style: TextStyle(
                                decoration: TextDecoration.underline),),

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
                          format(date),
                          style:
                          TextStyle(color: Colors.black54, fontSize: 12),
                        )),
                  ),
                ),
                Divider(
                  color: Colors.black54,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LikeButton(
                        likeCount:controller.View.value? numberOfLikes:null,
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
                            onTap: (){
                              Get.bottomSheet(
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: Comments.length,
                                        itemBuilder: (ctx, index) {
                                          return CommentScreen();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                elevation: 10,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        topLeft: Radius.circular(40))),
                                backgroundColor: Theme.of(context).backgroundColor,
                                enterBottomSheetDuration: const Duration(seconds: 1),
                                exitBottomSheetDuration: const Duration(seconds: 1),
                              );
                            },
                            child: Icon(
                              Icons.speaker_notes_outlined,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          controller.View.value?
                          Text(
                            numberOfComments,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ):Container(),
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
                ),
              ])),
    );
  }
}
class CommentScreen extends StatelessWidget {
  var commentControlller=TextEditingController();
  String? comment='yes';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                  placeholder: (context, url) =>
                      Image.asset('asset/image/loading.png'),
                  imageUrl:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTctFAgwn-HStqpjjSKJNYgUGg2xWe-T_r9bBH98zE4Og&s'),
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width-100,
                  child: TextField(
                    enabled: false,
                    decoration:InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      label: Text(comment!,),
                    ) ,
                  ),
                ),
              ],
            ),
          ],
        ),


      ),
    );

  }
}