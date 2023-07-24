import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class loginMiddleWare extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route) {
    if(sharedPreferences!.getString('access_token')!=null&&sharedPreferences!.getBool('topicsSelected')==false){
      return RouteSettings(name: '/topic');
    }
    if(sharedPreferences!.getBool('topicsSelected')==true&&sharedPreferences!.getString('access_token')!=null){
      return RouteSettings(name: '/home');
    }
  }
}