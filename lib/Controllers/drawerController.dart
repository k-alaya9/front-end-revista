import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Models/profile.dart';
import 'package:revista/main.dart';

import '../Services/Thems/themeservice.dart';
import '../Services/apis/profile_api.dart';
import '../View/Screens/homescreen.dart';
import '../View/Screens/profile_screen.dart';
import 'ProfileController.dart';

class drawerController extends GetxController with GetSingleTickerProviderStateMixin{
  ProfileController controller=Get.put(ProfileController());
   String darkMode = "asset/animations/47047-dark-mode-button.json";
   late AnimationController darkmodeController;
  var isLight = Get.isDarkMode.obs;
  var currentIndex=0.obs;

   String? imageUrl;
 String? userName;
   @override
  void onInit() async{
    super.onInit();
    darkmodeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 50));

    fetchData();
    await Future.delayed(Duration(seconds: 10));
  }

  fetchData()async{
    var token =sharedPreferences!.getString('access_token');
    try {
   Profile profile= await getProfileinfo(token);
   controller.id=profile.id;
   User user=profile.user;
   imageUrl=user.profile_image;
   userName=user.username;
   controller.Username=user.username;
   controller.profileImage=user.profile_image;
   controller.firstname=user.first_name;
   controller.lastName=user.last_name;
   controller.CoverImage=profile.cover_image;
   controller.bio=profile.bio;
   controller.following=profile.following_count.toString();
   controller.followers=profile.followers_count.toString();


    }
    catch(e){
      print(e);
    }
  }
  Widget currentScreen() {

    switch(currentIndex.value){
      case 0:{
        return HomeScreen();
      }

      case 1:
        return Scaffold(
          backgroundColor: Colors.green,
        );
        case 2:
        return Scaffold(
          backgroundColor: Colors.yellow,
        );
      case 3:
        return ProfileScreen();
      default:{
        return HomeScreen();
      }

    }
  }
  setIndex(index){
    currentIndex.value=index;
    update();
  }
   switchMode()async {
     await darkmodeController.animateTo(!isLight.value ? 0.5 : 1,duration: Duration(milliseconds: 50));
     isLight.value = !isLight.value;
     ThemeService().switchTheme();
   }

}