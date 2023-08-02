import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Models/hestoryModel.dart';
import 'package:revista/Services/apis/search_api.dart';

import '../Models/searchModel.dart';
import '../main.dart';

class SearchController extends GetxController{
  List <hestory>allData=[];
  List <search> searchResults=[];
  RefreshController refreshController = RefreshController();

  onRefresh() async {
    // monitor network fetch
    await fetchData();
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
  fetchData()async{
    try {
      final  data;
      final token =sharedPreferences!.getString('access_token');
      data = await getHestoryList(token);
     print(data);
      if (allData != data){
        allData.assignAll(data);
        print(allData);
      }
    } catch (e) {
      print(e);
    }

  }
  getSearch(query)async{
    final token =sharedPreferences!.getString('access_token');
    try{
      final List <search>data;
      data = await getSearchList(token,query);
      if (searchResults != data){
        searchResults.assignAll(data);
      }
    }catch(e){
      print(e);
    }
  }
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
}