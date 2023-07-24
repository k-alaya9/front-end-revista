import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PostController extends GetxController{
  List Comment=[];
  RxBool isAppBarVisible = true.obs;
  var id;
  var imageUrl;
  var username;
  var date;
  var nickName;
  var numberOfLikes;
  var numberOfComments;
  var url;
  var textPost;
  var userImage;
  var topics;
  late final ScrollController scrollController;

  fetchData(){

  }
  @override
  void onInit() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels <=
          scrollController.position.minScrollExtent &&
          !isAppBarVisible.value) {

        isAppBarVisible.value = true;

      } else if (scrollController.position.pixels >
          scrollController.position.minScrollExtent &&
          isAppBarVisible.value) {

        isAppBarVisible.value = false;

      }
    });
    super.onInit();
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  onNotification(notification) {
    if (notification is ScrollUpdateNotification ||
        notification is OverscrollNotification) {
      if (scrollController.position.pixels <=
          scrollController.position.minScrollExtent &&
          !isAppBarVisible.value) {

        isAppBarVisible.value = true;

      } else if (scrollController.position.pixels >
          scrollController.position.minScrollExtent &&
          isAppBarVisible.value) {

        isAppBarVisible.value = false;

      }
    }
    return true;
  }
}










