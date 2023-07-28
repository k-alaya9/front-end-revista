import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controllers/notifications_controller.dart';


class Notifications extends StatelessWidget {
   Notifications({Key? key,}) : super(key: key);
  notificationsController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    var date=DateFormat('yyyy-M-dd').parse(controller.dateTime);
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.13,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
        style: ListTileStyle.list,
        enabled: true,
        onTap: (){
        },
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(controller.imageUrl!)
            )
          ),
        ),
        title:Text(controller.Text!,style:  Theme.of(context).textTheme.bodyText1,),
        trailing: Padding(padding: EdgeInsets.fromLTRB(0, 30, 10, 0),child:Text("${DateFormat('yyyy-M-dd').format(date)}",style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Get.isDarkMode?Colors.white30:Colors.black26
        ),) ),
      ),
    );
  }
}
