import 'package:get/get.dart';

import '../Models/reply_model.dart';
import '../Services/apis/login_api.dart';
import '../Services/apis/reply_api.dart';

class ReplyController extends GetxController{
  List replys=[];
  fetchData() async {
    try {
      final List<reply> data;
      final token = getAccessToken();
      data = await getReplysList(token);
      if (replys != data) {
        replys.assignAll(data);
        print(replys);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void onInit() {
     fetchData();
     super.onInit();
  }
}