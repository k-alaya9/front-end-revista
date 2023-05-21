import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:revista/Controllers/onbordingcontroller.dart';
import 'package:revista/Services/Thems/themes.dart';
import 'package:revista/Services/Thems/themeservice.dart';
import 'package:revista/View/Screens/loginscreen.dart';
import 'package:revista/View/Screens/onboarding_screen.dart';
import 'package:revista/View/Screens/resetpassword_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View/Screens/forgetpasswordscreen.dart';
SharedPreferences? sharedPreferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  runApp(const MyApp());
}

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
      // home: LottieLearn(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=>OnBordingScreen(),middlewares: [onBoradingMiddleWare()]),
        GetPage(name: '/login', page: ()=>login()),
        GetPage(name: '/forgetpass', page: ()=>forgetPassword()),
        GetPage(name: '/resetpass', page: ()=>resetPassword()),
      ],
    );
  }
}

class LottieLearn extends StatefulWidget {
  const LottieLearn({Key? key}) : super(key: key);

  @override
  State<LottieLearn> createState() => _LottieLearnState();
}

class _LottieLearnState extends State<LottieLearn> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final AnimationController darkmodeController =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    final AnimationController favoriteController =
    AnimationController(vsync: this, duration: const Duration(seconds: 1));
    bool isLight = false;
    bool isFavorite = false;
    const String favoriteButton = "https://assets10.lottiefiles.com/packages/lf20_slDcnv.json";
    const String darkMode = "asset/animations/47047-dark-mode-button.json";

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(

          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                Text('Dark Mode'),
                InkWell(
                radius: 200,
                borderRadius: BorderRadius.circular(250),
                  splashColor: null,
                  hoverColor: null,
                  highlightColor: null,
                  overlayColor: null,
                  onTap: () async {
                    await darkmodeController.animateTo(isLight ? 0.5 : 1,duration: Duration(milliseconds: 500));
                    // controller.animateTo(0.5);
                    isLight = !isLight;
                    ThemeService().switchTheme();
                  },
                  child: Lottie.asset(darkMode, repeat: false, controller: darkmodeController,fit: BoxFit.contain,height: MediaQuery.of(context).size.height*0.1)),
            ],),
            // InkWell(
            //     onTap: () async {
            //       await favoriteController.animateTo(isFavorite ? 1 : 0);
            //       isFavorite = !isFavorite;
            //     },
            //     child: Lottie.network(favoriteButton, repeat: false, controller: favoriteController)),
          ],),
        ),
      ),
    );}}