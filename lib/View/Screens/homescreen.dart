
import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:revista/Services/apis/linking.dart';
import 'package:revista/View/Screens/DiscoverScreen.dart';
import 'package:revista/View/Screens/MessageScreen.dart';
import 'package:revista/View/Screens/createPost.dart';
import 'package:revista/View/Screens/home.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/cupertino.dart';
import '../../Controllers/ViewPostController.dart';
import '../../Controllers/homeController.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var v=Get.put(PostController(),permanent: true);

    homeController controller=Get.find();
    return SafeArea(
      child: Scaffold(
          body: NotificationListener<ScrollNotification>(
            onNotification: (value)=>controller.onNotification(value) ,
            child: controller.Homepages[controller.pageindex.value],
          ),
          extendBody: true,
          bottomNavigationBar: GetX(builder: (homeController controller)=> controller.isNavBarHidden.value
              ? SizedBox.shrink()
              : CurvedNavigationBar(
            height: 70,
            color:Theme.of(context).primaryColor,
            backgroundColor: Colors.transparent,
            index: controller.pageindex.value,
            onTap: (val)=>controller.pageindx(val),
            animationDuration: Duration(milliseconds: 1),
            items: [
              Icon(Icons.home,color: Colors.white,),
              Icon(Icons.search,color: Colors.white,),
              IconButton(icon:  Icon(Icons.add,color: Colors.white,),onPressed: (){
                Get.to(()=>CreatePost());
              }),
              Icon(Icons.chat,color: Colors.white,),
            ],
          ),)
      ),
    );
  }
}
