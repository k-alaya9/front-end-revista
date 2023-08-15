import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:readmore/readmore.dart';
import 'package:revista/Services/apis/reply_api.dart';

import '../../Controllers/commentController.dart';
import '../../Services/apis/comment_api.dart';
import '../../main.dart';
import '../Screens/ReplyScreen.dart';

class CommentScreen extends StatelessWidget {
  final id;
  final authorid;
  final comment;
  final username;
  final  date ;
  final numberOfLikesOfComments;
  final userImage;
  final type;
  var x=Get.put(CommentController());
  CommentController controller =Get.find();

  CommentScreen({super.key,
    required this.authorid,
    required this.comment,
    required this.username,
    required this.date,
    required this.numberOfLikesOfComments,
    required this.userImage, required this.id, required this.type});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 45,
                        height: 45,
                        placeholder: (context, url) =>
                            Image.asset('asset/image/loading.png'),
                        imageUrl: userImage),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text(username,style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(width:10,),
                            Row(
                              children: [
                                Container(
                                  child: Text(DateFormat('yyyy-mm-dd').add_Hms().parse(date.replaceAll('T',' ')).toString(),style: TextStyle(fontSize:10,color: Colors.black54 ),overflow: TextOverflow.clip),
                                ),
                                if(authorid==sharedPreferences!.getInt('access_id'))
                                PopupMenuButton<int>(
                                  icon: Icon(Icons.more_horiz),
                                  onSelected: (item) => handleClick(item),
                                  itemBuilder: (context) => [
                                      PopupMenuItem<int>(value: 0, child: Row(
                                        children: [
                                          Icon(Icons.delete,color: Colors.red,),
                                          Text('Delete comment'),
                                        ],
                                      ),),


                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 5,),
                        Container(
                          padding: EdgeInsets.only(left:0),
                          width: MediaQuery.of(context).size.width/2,
                          child: ReadMoreText(
                            comment!,
                            trimLines: 3,
                            textAlign: TextAlign.justify,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: ' More',
                            trimExpandedText: ' less',
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
                              fontSize: 12,
                              height: 2,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.only(left: 0),
                          height: 1,
                          width: 220,
                          color: Colors.grey[500],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: [
                              Text('Likes $numberOfLikesOfComments',style: TextStyle(color: Colors.grey),),
                              SizedBox(
                                width: 40,
                              ),
                              TextButton(
                                onPressed: (){
                                  print(id);
                                  Get.to(()=>ReplyScreen(),arguments: {
                                    'replyId':id,
                                  });
                                },
                                child: Text('Reply',style: TextStyle(color: Colors.grey[400]),),
                              ),
                            ],
                          ),
                        ),
                      ]
                  ),
                ),
                // LikeButton(
                //   likeBuilder: (isTapped) {
                //     return Icon(
                //       Icons.favorite,
                //       color: isTapped ? Colors.deepPurple : Colors.grey,
                //       size: 33,
                //     );
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<void> handleClick(int item) async {
    switch (item) {
      case 0:
        final token=sharedPreferences!.getString('access_token');
        if(type=='comment')
        await  deleteMyComment (token,id);
        else
          await deleteMyReply(token, id);
        break;


    }
  }
}
