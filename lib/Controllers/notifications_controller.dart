import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class notificationsController extends GetxController{
  String? Text='';
  String? imageUrl='';
  RefreshController refreshController =
  RefreshController(initialRefresh: true);

  void onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
}