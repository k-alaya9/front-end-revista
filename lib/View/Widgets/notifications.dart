import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/notifications_controller.dart';

class Notifications extends StatelessWidget {
   Notifications({Key? key,}) : super(key: key);
  notificationsController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.13,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12,width: 0.2)
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
        style: ListTileStyle.drawer,
        enabled: true,
        onTap: (){

        },
        leading: Container(child:CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(controller.imageUrl!)),
        ),
        title: Text(controller.username!,style: Theme.of(context).textTheme.bodyText1),
        subtitle: Text(controller.Text!,style:  Theme.of(context).textTheme.bodyText1,),
        trailing: Padding(padding: EdgeInsets.fromLTRB(0, 30, 10, 0),child:Text(controller.dateTime!,style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Get.isDarkMode?Colors.white30:Colors.black26
        ),) ),
      ),
    );
  }
}
