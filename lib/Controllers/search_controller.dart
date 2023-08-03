import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Models/hestoryModel.dart';
import 'package:revista/Models/post.dart';
import 'package:revista/Services/apis/post_api.dart';
import 'package:revista/Services/apis/search_api.dart';

import '../Models/searchModel.dart';
import '../Models/topic.dart';
import '../Services/apis/topic_api.dart';
import '../main.dart';

class SearchController extends GetxController{
  RxList <hestory>allData=<hestory>[].obs;
  RxList <search> searchResults=<search>[].obs;
  RefreshController refreshController = RefreshController();
  RxList<post>data=<post>[].obs;
  RxList<topicItem> topics=<topicItem>[].obs;
  var selected=true.obs;

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
      print(token);
      print('hi');
      final list=await getTopicsListPost(token);
      print(list);
      if(topics.isEmpty)
        for(var i in list) {
          topics.add(i);
          print(topics);
        }
      getlist(0);
    } catch (e) {
      print(e);
    }
  }
  getlist(id)async{
    try{
      final  listt;
      final token =sharedPreferences!.getString('access_token');
      listt = await getDiscoverList(token,id);
      print(listt);
      if (listt!= data){
        data.assignAll(listt);
        print(data);
      }
    }catch(e){
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