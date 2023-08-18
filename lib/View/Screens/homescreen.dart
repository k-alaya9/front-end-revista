import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:revista/Controllers/postController.dart';
import 'package:revista/Services/apis/linking.dart';
import 'package:revista/View/Screens/DiscoverScreen.dart';
import 'package:revista/View/Screens/MessageScreen.dart';
import 'package:revista/View/Screens/cameraScreen.dart';
import 'package:revista/View/Screens/createPost.dart';
import 'package:revista/View/Screens/home.dart';
import 'package:revista/View/Screens/streamsScreen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/cupertino.dart';
import '../../Controllers/ViewPostController.dart';
import '../../Controllers/homeController.dart';
import '../../Controllers/notifications_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    homeController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        body: NotificationListener<ScrollNotification>(
            onNotification: (value) => controller.onNotification(value),
            child: GetX(
              builder: (homeController controller) =>
                  controller.Homepages[controller.pageindex.value],
            )),
        extendBody: true,
        bottomNavigationBar: GetX(
          builder: (homeController controller) =>
              controller.isNavBarHidden.value
                  ? SizedBox.shrink()
                  : Container(
                color: Theme.of(context).backgroundColor,
                child: TabBar(
                  onTap: (val) => controller.pageindx(val),
                  controller: controller.TapController,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicator: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2),
                      )),
                  labelColor: Theme.of(context).primaryColor,
                  labelPadding: EdgeInsets.all(10),
                  automaticIndicatorColorAdjustment: true,
                  isScrollable: false,
                  tabs: [
                    controller.pageindex.value==0?Icon(
                      Icons.home,
                    ):Icon(Icons.home_outlined),
                    controller.pageindex.value==1?Icon(
                      Icons.explore,
                    ):Icon(Icons.explore_outlined),
                     controller.pageindex.value==2?
                     Icon(Icons.messenger):
                    Icon(Icons.messenger_outline),
                    Icon(Icons.live_tv)
                  ],
                ),
              )
        ),
        floatingActionButton: GetX(builder: (homeController controller)=> controller.isNavBarHidden.value?SizedBox.shrink():Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                shape: BoxShape.circle
            ),
            child: FloatingActionButton(
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    height: 100,
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()=>Get.toNamed('/CreatePost'),
                          splashFactory: NoSplash.splashFactory,
                          child: Column(
                            children: [
                              Icon(Icons.post_add,color: Get.isDarkMode?Colors.white:Colors.black,),
                              Text(translator.translate("Create Post"),style: Theme.of(context).textTheme.bodyText1,),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(()=>MyAppdd(role: true,));
                          },
                          splashFactory: NoSplash.splashFactory,
                          child: Column(
                            children: [
                              Icon(Icons.live_tv_outlined,color: Get.isDarkMode?Colors.white:Colors.black,),
                              Text(translator.translate("Create Live"),style: Theme.of(context).textTheme.bodyText1,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  backgroundColor: Theme.of(context).backgroundColor,
                  enableDrag: true,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    )
                  )
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 5,
              isExtended: true,
            )),),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}