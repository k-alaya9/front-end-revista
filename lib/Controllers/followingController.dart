import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Models/followmodel.dart';

class followingController extends GetxController{
  List<follow>? followers=[];
  List<follow>? followings=[];
  var isSearching=false.obs;
  switchSearch(){
    isSearching.value=!isSearching.value;
  }
  RefreshController refreshController=RefreshController();
  onRefresh()async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
}