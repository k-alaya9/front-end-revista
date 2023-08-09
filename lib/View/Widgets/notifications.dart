import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controllers/notifications_controller.dart';
import '../Screens/ReplyScreen.dart';
import '../Screens/ViewPost.dart';


class Notifications extends StatelessWidget {
   Notifications({Key? key, this.id, this.type, this.text, this.dateTime, this.imageUrl,}) : super(key: key);
   final id;
   final type;
   final text;
   final dateTime;
   final imageUrl;
  notificationsController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    var date=DateFormat('yyyy-M-dd').parse(dateTime);
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.13,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
        style: ListTileStyle.list,
        enabled: true,
        onTap: (){
          var id=this.id;
          print(id);
          switch(type){
            case 'Follow':
               Get.toNamed('/visitProfile',
                  arguments: {
                    'id':id
                  }
              );
              break;
            case "Post":
               Get.to(()=>ViewPost(),arguments: {
                'postId':id
              });
              break;
            case 'Reply':
               Get.to(()=>ReplyScreen(),arguments: {
                'replyId':id
              });
              break;
            case'Chat':
               Get.toNamed('/chatScreen',arguments: {
                'chat_id':id
              });
              break;
          }
        },
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageUrl)
            )
          ),
        ),
        title:Text(text,style:  Theme.of(context).textTheme.bodyText1,),
        trailing: Padding(padding: EdgeInsets.fromLTRB(0, 30, 10, 0),child:Text("${DateFormat('yyyy-M-dd').format(date)}",style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Get.isDarkMode?Colors.white30:Colors.black26
        ),) ),
      ),
    );
  }
}
