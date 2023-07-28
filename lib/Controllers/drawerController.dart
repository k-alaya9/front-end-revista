import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/homeController.dart';
import 'package:revista/Controllers/postController.dart';
import 'package:revista/Models/profile.dart';
import 'package:revista/main.dart';

import '../Services/Thems/themeservice.dart';
import '../Services/apis/profile_api.dart';
import '../View/Screens/homescreen.dart';
import '../View/Screens/profile_screen.dart';
import 'ProfileController.dart';
import 'ViewPostController.dart';

class drawerController extends GetxController with GetSingleTickerProviderStateMixin{
  ProfileController controller=Get.put(ProfileController(),);
  homeController _controller=Get.put(homeController());
   String darkMode = "asset/animations/47047-dark-mode-button.json";
   late AnimationController darkmodeController;
  var isLight = Get.isDarkMode.obs;
  var currentIndex=0.obs;

   RxString imageUrl=''.obs;
 RxString userName=''.obs;
   @override
  void onInit() async{
    super.onInit();
    darkmodeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 50));
    await fetchData();

  }

  fetchData()async{
    var token =sharedPreferences!.getString('access_token');
    try {
   Profile profile= await getProfileinfo(token);
   controller.id=profile.id;
   User user=profile.user;
   imageUrl.value=user.profile_image;
   userName.value=user.username;
   controller.Username.value=user.username;
   controller.profileImage.value=user.profile_image;
   controller.firstname.value=user.first_name;
   controller.lastName.value=user.last_name;
   controller.CoverImage.value=profile.cover_image;
   controller.bio.value=profile.bio;
   controller.following.value=profile.following_count.toString();
   controller.followers.value=profile.followers_count.toString();

      // userName.value = 'k.alaya9';
      // imageUrl.value =
      //     'https://yt3.ggpht.com/nwHdCPYKiRwHXyPWesblZAuJ2ybHTnu7wM_wInj6LHJrobXP62f9NRDW_lTqu4wXKf_aY7ZKS-E=s88-c-k-c0x00ffffff-no-nd-rj';
      // controller.firstname!.value = 'khaled';
      // controller.lastName!.value = 'alaya';
      // controller.CoverImage!.value = 'https://scontent-cph2-1.xx.fbcdn.net/v/t39.30808-6/352379080_585186983746695_5892930268755518858_n.jpg?stp=dst-jpg_p960x960&_nc_cat=104&ccb=1-7&_nc_sid=e3f864&_nc_ohc=p0LMLrYOx1wAX-WfmC4&_nc_ht=scontent-cph2-1.xx&oh=00_AfCRdRNMZm19CK9SewSjvbbqXPg46dVMcWkrae2gQ3fF8g&oe=64840E3C';
      // controller.bio!.value = 'lana del rey';
      // controller.following!.value = '2000';
      // controller.followers!.value = '2000';
      // controller.numberOfPosts!.value = '10';
    }
    catch(e){
      print(e);
    }
  }
  Widget currentScreen() {
    // ZoomDrawer.of(Get.context!)!.toggle();
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