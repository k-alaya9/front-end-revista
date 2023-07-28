import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Services/apis/chat_api.dart';

import '../Models/chatModel.dart';
import '../main.dart';

class messageScreenController extends GetxController{
  List <chat>chats=[];
  RefreshController refreshController = RefreshController(initialRefresh: true);
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
  void onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
     await  fetchData();
    refreshController.refreshCompleted();
  }
  fetchData() async {
    var token = sharedPreferences!.getString('access_token');
    try {
      final data;
      data = await getChats(token);
      chats.assignAll(data);
      print(chats);
    } catch (e) {
      print(e);
    }
  }
}