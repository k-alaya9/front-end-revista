import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:revista/Controllers/postController.dart';
import 'package:revista/Services/apis/comment_api.dart';
import 'package:revista/main.dart';
import '../Models/post.dart';
import '../Models/comment_model.dart';

class PostController extends GetxController{
  List<comment> Comment=[
    ];
  RxBool isAppBarVisible = true.obs;
  var authorId=0.obs;
  var id=0.obs;
  var imageUrl=''.obs;
  var username=''.obs;
  var date;
  var nickName=''.obs;
  var numberOfLikes=''.obs;
  var numberOfComments=''.obs;
  var url=''.obs;
  var textPost=''.obs;
  var userImage=''.obs;
  var topics=[].obs;
  late final ScrollController scrollController;
  viewPostController controller=Get.find();
  @override
  void onInit() async{
    print('hi');
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
   await fetchData();
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
  fetchData()async{
    try{
      final token=sharedPreferences!.getString('access_token');
      id.value=Get.arguments['postId'];
      print(id);
      final post Post=await getPost(token, id);
      authorId.value=Post.author!.id!;
      imageUrl.value=Post.image!;
      username.value=Post.author!.user!.username!;
      date=Post.createdAt!;
      nickName.value=Post.author!.user!.firstName!+' '+Post.author!.user!.lastName!;
      numberOfLikes.value=Post.likesCount.toString();
      numberOfComments.value=Post.commentsCount.toString();
      url.value=Post.link!;
      textPost.value=Post.content!;
      userImage.value=Post.author!.user!.profileImage!;
      topics.value=Post.topics!;
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
}










