import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Services/apis/topic_api.dart';
import 'package:revista/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/topic.dart';

class TopicController extends GetxController{
  RxBool onLoading=false.obs;
   List<topicItem>items=[];
   List<int?> selecteditems=[];
   RxBool topicsSelected=false.obs;
   @override
  onInit()async{
     await fetchData();
     sharedPreferences!.setBool('topicsSelected', topicsSelected.value);
    super.onInit();
   }

   sendData()async{
     List<Map<String,int>>Data=[];
     for(var i in selecteditems){
       Data.add({'topic':i!});
     }
     if (selecteditems.isEmpty){
       showCupertinoDialog(
           context: Get.context!,
           builder: (context) {
             return CupertinoAlertDialog(
               title: Text('Error',style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.black)),
               content: Text("pick topic post",style: Theme.of(context).textTheme.bodyText1,),
               actions:[
                 TextButton(
                     onPressed: () {
                       Get.back();
                     },
                     child: Text('ok',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).primaryColor),))
               ],
             );
           });
     }else {
       print(Data);
       try {
         SharedPreferences prefs = await SharedPreferences.getInstance();
         print(prefs.getString('access_token'));
         await sendTopicList(prefs.getString('access_token')!, Data);
       } catch (e) {
         showSnackBar(e);
       }
     }
   }

  onPressed(int id){
    for(var item in items){
      if(item.id==id) {
        item.pressed.value=!item.pressed.value;
      }
      if(item.id==id &&item.pressed.value){
        selecteditems.add(id);
        print(selecteditems);
      }
      if(item.id==id &&!item.pressed.value){
        selecteditems.remove(id);
        print(selecteditems);
      }
    }
    update();
  }
  fetchData()async{

     try{
       SharedPreferences prefs=await SharedPreferences.getInstance();
       print(prefs.getString('access_token'));
       var list=await getTopicsList(prefs.getString('access_token'));
       if(items.isEmpty)
       for(var i in list){
           items.add(i);
         print(items);
       }
     }
     catch(e){
       showSnackBar(e);
       print(e);
     }
  }
  void showSnackBar(var e) {
    Get.showSnackbar(GetSnackBar(
      borderRadius: 20,
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: Colors.white,
      ),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.all(10),
      messageText: Text(e.toString()),
    ));
  }
}