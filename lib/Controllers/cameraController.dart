import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Services/apis/live_api.dart';
import 'package:revista/main.dart';

import '../Models/live.dart';

class cameraController extends GetxController{
  List<live> Streams=<live>[].obs;

  RefreshController refreshController =
  RefreshController(initialRefresh: true);
  void onRefresh() async {
    // monitor network fetch
    await fetchData();
    refreshController.refreshCompleted();
  }
  @override
  void onInit() async{
    fetchData();
    super.onInit();
  }
  @override
  void dispose() {
    super.dispose();
  }
  fetchData()async{
    var token=sharedPreferences!.getString('access_token');
    try{
      var data;
      data =await getLives(token);
      if(data!=Streams){
        Streams.assignAll(data);
      }
    }catch(e) {
    print(e);
    }
  }
}