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
            backgroundImage: NetworkImage('https://www.shutterstock.com/image-vector/man-icon-vector-600w-1040084344.jpg')),
        ),
        title: Text('Notifications',style: Theme.of(context).textTheme.bodyText1),
        subtitle: Text('Notifications deatils',style:  Theme.of(context).textTheme.bodyText1,),
        trailing: Padding(padding: EdgeInsets.fromLTRB(0, 30, 10, 0),child:Text('DateTime',style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Get.isDarkMode?Colors.white30:Colors.black26
        ),) ),
      ),
    );
  }
}
