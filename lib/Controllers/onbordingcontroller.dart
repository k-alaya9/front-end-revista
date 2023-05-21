import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:revista/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBordingController extends GetxController{
 RxBool isLast=false.obs;
 RxBool firstTimer=true.obs;

 void changeIndex(index){
   isLast.value=(index==3);
 }
 switchFirsTimer()async{
   firstTimer.value=false;
   print(firstTimer.value);
   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   sharedPreferences.setBool('firstTimer', firstTimer.value);
   Get.offNamed('/login');
 }
}
class onBoradingMiddleWare extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route) {
    if(sharedPreferences!.getBool('firstTimer')==null){
      sharedPreferences!.setBool('firstTimer',true);
    }
    if(sharedPreferences!.getBool('firstTimer')==false){
      return RouteSettings(name: '/login');
    }

  }
}