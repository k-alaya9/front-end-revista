import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class loginMiddleWare extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route) {
    if(sharedPreferences!.getString('access_token')!=null&&sharedPreferences!.getBool('topicsSelected')==false){
      print('hi from R');
      return RouteSettings(name: '/topic');
    }
    else if(sharedPreferences!.getBool('topicsSelected')==true&&sharedPreferences!.getString('access_token')!=null){
      print('bye from R');
      return RouteSettings(name: '/home');
    }
  }
}