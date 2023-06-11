import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/onbordingcontroller.dart';
import 'package:revista/Services/Thems/themes.dart';
import 'package:revista/Services/Thems/themeservice.dart';
import 'package:revista/View/Screens/EditProfielScreen.dart';
import 'package:revista/View/Screens/followersScreen.dart';
import 'package:revista/View/Screens/loginscreen.dart';
import 'package:revista/View/Screens/onboarding_screen.dart';
import 'package:revista/View/Screens/resetpassword_screen.dart';
import 'package:revista/View/Widgets/drawer.dart';
import 'package:revista/middleware/loginMIddleware.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'View/Screens/createPost.dart';
import 'View/Screens/followingScreen.dart';
import 'View/Screens/forgetpasswordscreen.dart';
import 'View/Screens/notification_screen.dart';
import 'View/Screens/profile_screen.dart';
import 'View/Screens/register_screen.dart';
import 'View/Screens/topicsscreen.dart';
import 'View/Screens/visiterProfile.dart';
SharedPreferences? sharedPreferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  runApp(const MyApp());
}
//ToDo AnimationConfiguration.staggeredList SlideAnimation FadeInAnimation flutter_staggered_animations: ^1.1.1
//ToDo Hero animation


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    OnBordingController _controller=Get.put(OnBordingController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'revista',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      builder: EasyLoading.init(),
      initialRoute: '/home',
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 500),
      getPages: [
        GetPage(name: '/', page: ()=>OnBordingScreen(),middlewares: [onBoradingMiddleWare()],),
        GetPage(name: '/login', page: ()=>login(),middlewares: [loginMiddleWare()]),
        GetPage(name: '/register', page: ()=>Register()),
        GetPage(name: '/forgetpass', page: ()=>forgetPassword()),
        GetPage(name: '/resetpass', page: ()=>resetPassword()),
        GetPage(name: '/topic', page: ()=>TopicScreen()),
        GetPage(name: '/notification', page: ()=>notification_screen()),
        GetPage(name: '/home', page: ()=>Home()),
        GetPage(name: '/CreatePost', page: ()=>CreatePost()),
        GetPage(name: '/EditProfile', page: ()=>EditProfileScreen()),
        GetPage(name: '/followers', page: ()=>FollowersScreen()),
        GetPage(name: '/following', page: ()=>FollowingScreen()),
        GetPage(name: '/visitProfile', page: ()=>visiterProfileScreen()),
        GetPage(name: '/Profile', page: ()=>ProfileScreen()),
      ],
    );
  }
}
