import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/followingController.dart';


class followerList extends StatelessWidget {
  final username;
  final name;
  final imageUrl;
  followerList({Key? key, this.username, this.name, this.imageUrl,}) : super(key: key);
  followingController controller=Get.find();
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
          Get.toNamed('/visitProfile');
        },
        leading: Container(child:CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(imageUrl)),
        ),
        title: Text(name,style: Theme.of(context).textTheme.bodyText1),
        subtitle: Text(username,style:  Theme.of(context).textTheme.bodyText1,),
      ),
    );
  }
}
