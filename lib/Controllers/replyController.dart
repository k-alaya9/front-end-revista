import 'package:get/get.dart';
import 'package:revista/Services/apis/reply_api.dart';

import '../Models/reply_model.dart';
import '../main.dart';
class ReplyController extends GetxController{
  RxList <reply>Replies = <reply>[].obs;
  var id=0.obs;
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
    data = await getReplysList(token,id.value);
    if (Replies != data){
      Replies.assignAll(data);
    }
  } catch (e) {
    print(e);
  }
}}