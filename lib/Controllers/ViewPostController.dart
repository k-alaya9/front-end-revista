import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:revista/Controllers/postController.dart';
import 'package:revista/Services/apis/comment_api.dart';
import 'package:revista/main.dart';

import '../Models/comment_model.dart';
import '../View/Widgets/post.dart';

class PostController extends GetxController{
  List Comment=[

  ];
  RxBool isAppBarVisible = true.obs;
  var authorId;
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
  viewPostController controller=Get.find();
  fetchData()async{
    try{
      final token=sharedPreferences!.getString('access token');
      id=Get.arguments['postId'];
      final Post post=await getPost(token, id);
      authorId=post.authorId;
      imageUrl=post.imageUrl;
      username=post.username;
      date=post.date;
      nickName=post.nickName;
      numberOfLikes=post.numberOfLikes;
      numberOfComments=post.numberOfComments;
      url=post.url;
      textPost=post.textPost;
      userImage=post.userImage;
      topics=post.topics;
      final List <comment> data;
      data =await getCommentsList(token,id);
      if(Comment != data && data != null)
        {
          Comment.assignAll(data);
        }
    }
    catch(e){
     print (e);
    }
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










