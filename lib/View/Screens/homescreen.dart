import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/postController.dart';
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
                  : TabBar(
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
                        Icon(
                          Icons.home,
                        ),
                        Icon(
                          Icons.search,
                        ),
                        Icon(Icons.messenger_outline),
                        Icon(Icons.notifications_active_outlined)
                      ],
                    ),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            shape: BoxShape.circle
          ),
            child: FloatingActionButton(
          onPressed: () => Get.toNamed('/CreatePost'),
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              isExtended: true,
        )),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}