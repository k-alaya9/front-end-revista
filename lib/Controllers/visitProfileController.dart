import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class visitProfileController extends GetxController{
  RefreshController refreshController =
  RefreshController(initialRefresh: true);
  List Posts = List.generate(5, (index) => null);
  RxString? profileImage;
  RxString?  CoverImage;
  RxString?  firstname;
  RxString?  lastName;
  RxString?  Username;
  RxString?  followers;
  RxString?  following;
  RxString?  numberOfPosts;
  RxString?  bio;
  var isFollowing=false.obs;
  ScrollController scrollController = ScrollController();
  final ListKey=GlobalKey();
  void onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  follow(){
    isFollowing.value=!isFollowing.value;
  }
  showImage(photo){
    Get.dialog(
      Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: NetworkImage(photo),
              fit: BoxFit.cover),
        ),
        child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      useSafeArea: true,
    );
  }
}