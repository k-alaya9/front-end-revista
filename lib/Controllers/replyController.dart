import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Services/apis/reply_api.dart';

import '../Models/reply_model.dart';
import '../main.dart';
class ReplyController extends GetxController{
  RxList <reply>Replies = <reply>[].obs;
  var id=0.obs;
  var authorid=0.obs;
  var idcomment=0.obs;
  var comment=''.obs;
  var username=''.obs;
  var date='2002-2-21'.obs;
  var userImage=''.obs;
  RefreshController refreshController =
  RefreshController(initialRefresh: true);
  void onRefresh() async {
    // monitor network fetch
    await fechData();
    refreshController.refreshCompleted();
  }
@override
  onInit(){
  id.value=Get.arguments['replyId'];
  print(id.value);
  fechData();
    super.onInit();
}

fechData()async{
  try {
    final List<reply> data;
    final token =sharedPreferences!.getString('access_token');
    reply comment=await getComment(token,id);
    authorid.value=comment.author!.id!;
    idcomment.value=comment.id!;
    this.comment.value=comment.content!;
    date.value=comment.createdAt!;
    username.value=comment.author!.user!.username!;
    userImage.value=comment.author!.user!.profileImage!;
    data = await getReplysList(token,id.value);
    if (Replies != data){
      Replies.assignAll(data);
    }


  } catch (e) {
    print(e);
  }
}}