import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/postController.dart';

import '../Services/apis/live_api.dart';
import '../View/Screens/DiscoverScreen.dart';
import '../View/Screens/MessageScreen.dart';
import '../View/Screens/cameraScreen.dart';
import '../View/Screens/home.dart';
import '../View/Screens/notification_screen.dart';
import '../View/Screens/streamsScreen.dart';
import '../main.dart';
import 'ViewPostController.dart';

class homeController extends GetxController with GetSingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  RxBool isNavBarHidden = false.obs;
  late final TapController;
  final formKey = GlobalKey<FormState>();
  var textController=TextEditingController();
  var descController=TextEditingController();
  var title;
  var decsription;
  @override
  onInit(){
    TapController=  TabController(length:Homepages.length , vsync: this,initialIndex: pageindex.value,animationDuration: Duration(milliseconds: 500));

  }
  onNotification(notification) {
    if (notification is ScrollUpdateNotification) {
      if (!isNavBarHidden.value) {

        isNavBarHidden.value = true;
      }
    } else if (notification is ScrollEndNotification) {
      if (isNavBarHidden.value) {
        isNavBarHidden.value = false;

      }
    }
    return true;
  }
  var pageindex = 0.obs;
  List Homepages = [
    PostScreen(),
    DiscoverScreen(),
    MessageScreen(),
    Lives()
  ];

  submit()async{
    if(formKey.currentState!.validate()==true){
      formKey.currentState!.save();
      var token=sharedPreferences!.getString('access_token');
      var id=await createLive(token: token,text: title,description: decsription);
      Get.to(()=>MyAppdd(role: true,),arguments:{
        'channel':id
      });
      textController.clear();
      descController.clear();
    }
  }
  getpage() {
    return Homepages[pageindex.value];
  }
  pageindx(index) {
  pageindex.value = index;
  }


}