import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/postController.dart';

import '../View/Screens/DiscoverScreen.dart';
import '../View/Screens/MessageScreen.dart';
import '../View/Screens/home.dart';
import 'ViewPostController.dart';

class homeController extends GetxController{

  final ScrollController scrollController = ScrollController();
  RxBool isNavBarHidden = false.obs;
  onNotification(notification) {
    if (notification is ScrollUpdateNotification) {
      if (!isNavBarHidden.value) {

        isNavBarHidden.value = true;
      }
    } else if (notification is ScrollEndNotification) {
      if (isNavBarHidden.value) {
        isNavBarHidden.value = false;

      }
    }
    return true;
  }
  var pageindex = 0.obs;
  List Homepages = [
    PostScreen(),
    DiscoverScreen(),
    Container(),
    MessageScreen(),
  ];


  getpage() {
    return Homepages[pageindex.value];
  }
  pageindx(index) {
  pageindex.value = index;
  }


}